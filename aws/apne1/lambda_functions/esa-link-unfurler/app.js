const { App, AwsLambdaReceiver } = require("@slack/bolt");
const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { GetItemCommand, PutItemCommand } = require("@aws-sdk/client-dynamodb");
const dayjs = require("dayjs");
const relativeTime = require("dayjs/plugin/relativeTime");

dayjs.extend(relativeTime);

const dynamoDBClient = new DynamoDBClient();
const CACHE_TTL_SECONDS = 60 * 60; // 1 hour in seconds

const awsLambdaReceiver = new AwsLambdaReceiver({
  signingSecret: process.env.SLACK_SIGNING_SECRET,
});

const app = new App({
  token: process.env.SLACK_BOT_TOKEN,
  receiver: awsLambdaReceiver,
});

const extractPostNumber = (url) => {
  const match = url.match(/.+\.esa\.io\/posts\/(\d+)/);
  return match ? match[1] : null;
};

const getCachedPost = async (url) => {
  try {
    const command = new GetItemCommand({
      TableName: process.env.DYNAMODB_TABLE_NAME,
      Key: {
        url: { S: url },
      },
    });

    const response = await dynamoDBClient.send(command);

    if (!response.Item) {
      return null;
    }

    // DynamoDB TTL will automatically delete expired items
    // If the item exists, it's still valid
    return JSON.parse(response.Item.postData.S);
  } catch (error) {
    console.error(`Error getting cached post: ${error.message}`);
    return null;
  }
};

const setCachedPost = async (url, postData) => {
  try {
    const ttlTimestamp = Math.floor(Date.now() / 1000) + CACHE_TTL_SECONDS;
    const command = new PutItemCommand({
      TableName: process.env.DYNAMODB_TABLE_NAME,
      Item: {
        url: { S: url },
        postData: { S: JSON.stringify(postData) },
        ttl: { N: ttlTimestamp.toString() },
      },
    });

    await dynamoDBClient.send(command);
  } catch (error) {
    console.error(`Error setting cached post: ${error.message}`);
  }
};

const getEsaPost = async (url, number) => {
  // Try to get from cache first
  const cachedData = await getCachedPost(url);
  if (cachedData) {
    console.log(`Cache hit for post ${number} (${url})`);
    return cachedData;
  }

  // Cache miss - fetch from ESA API
  console.log(`Cache miss for post ${number} (${url}), fetching from esa.io API`);
  const response = await fetch(
    `https://api.esa.io/v1/teams/${process.env.ESA_TEAM_NAME}/posts/${number}?include=comments`,
    { headers: { Authorization: `Bearer ${process.env.ESA_ACCESS_TOKEN}` } }
  );
  if (!response.ok) {
    const errorText = await response.text();
    console.error(`ESA API error (${response.status}): ${errorText}`);
    throw new Error(`Error fetching ESA post ${number}: ${response.status} ${response.statusText}`);
  }
  const data = await response.json();

  // Save to cache
  await setCachedPost(url, data);

  return data;
};

app.event("link_shared", async ({ event, client, logger }) => {
  logger.info(event);
  const { links, channel, message_ts } = event;

  try {
    const unfurls = {};

    for (const link of links) {
      const postNumber = extractPostNumber(link.url);
      if (!postNumber) {
        logger.info(`Skipping non-esa URL: ${link.url}`);
        continue;
      }

      logger.info(`Fetching esa post: ${postNumber} from URL: ${link.url}`);
      const post = await getEsaPost(link.url, postNumber);

      if (!post || !post.updated_at || !post.full_name) {
        logger.error(`Invalid post data for ${postNumber}:`, JSON.stringify(post));
        continue;
      }

      logger.info(`Post data for ${postNumber}:`, {
        full_name: post.full_name,
        updated_at: post.updated_at,
        created_by: post.created_by,
        updated_by: post.updated_by,
      });

      // Calculate relative time using dayjs
      const timeText = `last updated at ${dayjs(post.updated_at).fromNow()}`;

      // Build context elements with user info
      const contextElements = [];

      if (post.created_by && post.created_by.icon && post.created_by.screen_name) {
        contextElements.push({
          type: "image",
          image_url: post.created_by.icon,
          alt_text: post.created_by.screen_name,
        });
        contextElements.push({
          type: "mrkdwn",
          text: `created by: ${post.created_by.screen_name}`,
        });
      }

      if (post.updated_by && post.updated_by.icon && post.updated_by.screen_name) {
        contextElements.push({
          type: "image",
          image_url: post.updated_by.icon,
          alt_text: post.updated_by.screen_name,
        });
        contextElements.push({
          type: "mrkdwn",
          text: `last updated by: ${post.updated_by.screen_name}`,
        });
      }

      // https://docs.slack.dev/messaging/formatting-message-text/#escaping
      const escapedFullName = post.full_name.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;");
      const blocks = [
        {
          type: "section",
          text: {
            type: "mrkdwn",
            text: `*<${link.url}|${escapedFullName}>*`,
          },
        },
        {
          type: "context",
          elements: [
            {
              type: "mrkdwn",
              text: timeText,
            },
          ],
        },
      ];

      // if (contextElements.length > 0) {
      //   blocks.push({
      //     type: "context",
      //     elements: contextElements,
      //   });
      // }

      unfurls[link.url] = { blocks };
    }

    if (Object.keys(unfurls).length > 0) {
      logger.info("Sending unfurls:", JSON.stringify(unfurls, null, 2));
      await client.chat.unfurl({
        channel,
        ts: message_ts,
        unfurls,
      });
      logger.info("Unfurl completed successfully");
    }
  } catch (error) {
    logger.error(`Error unfurling esa links: ${error.message}`);
    if (error.code === 'slack_webapi_platform_error' && error.data) {
      logger.error('Slack API error details:', JSON.stringify(error.data, null, 2));
    }
    logger.error('Full error:', JSON.stringify(error, Object.getOwnPropertyNames(error), 2));
  }
});

module.exports.handler = async (event, context, callback) => {
  const handler = await awsLambdaReceiver.start();
  return handler(event, context, callback);
};
