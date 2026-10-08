resource "aws_cloudwatch_log_group" "signage_app_iot_handler" {
  name              = "/aws/lambda/${local.signage_app.name_prefix}-iot-handler"
  retention_in_days = 3
}

resource "aws_cloudwatch_log_group" "signage_app_dev_iot_handler" {
  name              = "/aws/lambda/${local.signage_app_dev.name_prefix}-iot-handler"
  retention_in_days = 3
}
