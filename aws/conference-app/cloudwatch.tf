resource "aws_cloudwatch_log_group" "conference_app_worker" {
  provider          = aws.usw2
  name              = "/ecs/conference-app-worker"
  retention_in_days = 3
}
