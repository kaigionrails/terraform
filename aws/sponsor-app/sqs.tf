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

resource "aws_sqs_queue" "sponsor_app_lambdakiq_staging" {
  name = "sponsor-app-lambdakiq-staging"

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.sponsor_app_lambdakiq_dlq_staging.arn
    maxReceiveCount     = 13
  })

  visibility_timeout_seconds = 301

  tags = {
    Environment = "staging"
  }
}

resource "aws_sqs_queue" "sponsor_app_lambdakiq_dlq_staging" {
  name = "sponsor-app-lambdakiq-dlq-staging"

  tags = {
    Environment = "staging"
  }
}
