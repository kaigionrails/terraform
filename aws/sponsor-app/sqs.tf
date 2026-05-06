resource "aws_sqs_queue" "sponsor_app_lambdakiq" {
  name = "sponsor-app-lambdakiq"

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.sponsor_app_lambdakiq_dlq.arn
    maxReceiveCount     = 13
  })

  visibility_timeout_seconds = 301

  tags = {
    Environment = "production"
  }
}

resource "aws_sqs_queue" "sponsor_app_lambdakiq_dlq" {
  name = "sponsor-app-lambdakiq-dlq"

  tags = {
    Environment = "production"
  }
}

resource "aws_sqs_queue" "sponsor_app_staging_lambdakiq" {
  name = "sponsor-app-staging-lambdakiq"

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.sponsor_app_staging_lambdakiq_dlq.arn
    maxReceiveCount     = 13
  })

  visibility_timeout_seconds = 301

  tags = {
    Environment = "staging"
  }
}

resource "aws_sqs_queue" "sponsor_app_staging_lambdakiq_dlq" {
  name = "sponsor-app-staging-lambdakiq-dlq"

  tags = {
    Environment = "staging"
  }
}
