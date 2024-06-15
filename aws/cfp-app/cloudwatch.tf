resource "aws_cloudwatch_log_group" "cfp_app_worker" {
  provider          = aws.usw2
  name              = "/ecs/cfp-app-worker"
  retention_in_days = 3
}
