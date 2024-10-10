resource "aws_cloudwatch_log_group" "sponsor_app_worker" {
  provider          = aws.usw2
  name              = "/ecs/sponsor-app-worker"
  retention_in_days = 3
}

resource "aws_cloudwatch_log_group" "sponsor_app_staging_worker" {
  provider          = aws.usw2
  name              = "/ecs/sponsor-app-staging-worker"
  retention_in_days = 3
}
