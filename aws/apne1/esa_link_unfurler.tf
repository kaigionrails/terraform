resource "terraform_data" "zipper" {
  triggers_replace = [
    filesha256("lambda_functions/esa-link-unfurler/app.js"),
    filesha256("lambda_functions/esa-link-unfurler/package.json"),
    filesha256("lambda_functions/esa-link-unfurler/package-lock.json"),
  ]

  provisioner "local-exec" {
    command     = "npm install"
    working_dir = "lambda_functions/esa-link-unfurler"
  }
}

data "archive_file" "esa_link_unfurler_zip" {
  type        = "zip"
  source_dir  = "lambda_functions/esa-link-unfurler"
  output_path = "lambda_functions/esa-link-unfurler.zip"

  depends_on = [terraform_data.zipper]
}

resource "aws_lambda_function" "esa_link_unfurler" {
  function_name    = "esa-link-unfurler"
  filename         = data.archive_file.esa_link_unfurler_zip.output_path
  source_code_hash = data.archive_file.esa_link_unfurler_zip.output_base64sha256
  handler          = "app.handler"
  runtime          = "nodejs22.x"
  role             = aws_iam_role.esa_link_unfurler_lambda.arn

  environment {
    variables = {
      SLACK_SIGNING_SECRET = "secretvalue"
      SLACK_BOT_TOKEN      = "secretvalue"
      DYNAMODB_TABLE_NAME  = aws_dynamodb_table.esa_link_unfurler_cache.id
      ESA_TEAM_NAME        = "kaigionrails"
      ESA_ACCESS_TOKEN     = "secretvalue"
    }
  }
  lifecycle {
    ignore_changes = [
      environment[0].variables["SLACK_SIGNING_SECRET"],
      environment[0].variables["SLACK_BOT_TOKEN"],
      environment[0].variables["ESA_ACCESS_TOKEN"],
    ]
  }
}

resource "aws_lambda_function_url" "esa_link_unfurler" {
  function_name      = aws_lambda_function.esa_link_unfurler.function_name
  authorization_type = "NONE"
}

resource "aws_lambda_permission" "allow_public_invoke_esa_link_unfurler" {
  statement_id  = "AllowPublicInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.esa_link_unfurler.function_name
  principal     = "*"
}

resource "aws_dynamodb_table" "esa_link_unfurler_cache" {
  name         = "esa-link-unfurler-cache"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "url"

  attribute {
    name = "url"
    type = "S"
  }
  ttl {
    enabled        = true
    attribute_name = "ttl"
  }
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "esa_link_unfurler_policy" {
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:UpdateItem",
    ]
    resources = [aws_dynamodb_table.esa_link_unfurler_cache.arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
}

resource "aws_iam_role" "esa_link_unfurler_lambda" {
  name               = "EsaLinkUnfurlerLambda"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_iam_role_policy" "esa_link_unfurler_policy" {
  role   = aws_iam_role.esa_link_unfurler_lambda.id
  policy = data.aws_iam_policy_document.esa_link_unfurler_policy.json
}

