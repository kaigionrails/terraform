data "archive_file" "signage_app_iot_handler" {
  type        = "zip"
  source_file = "lambda_functions/iot-handler/iot_handler.rb"
  output_path = "lambda_functions/iot-handler.zip"
}

resource "aws_lambda_function" "signage_app_iot_handler" {
  function_name = "${local.signage_app.name_prefix}-iot-handler"

  filename         = data.archive_file.signage_app_iot_handler.output_path
  source_code_hash = data.archive_file.signage_app_iot_handler.output_base64sha256
  handler          = "iot_handler.handle"
  runtime          = "ruby3.4"
  architectures    = ["arm64"]

  role = aws_iam_role.signage_app_iot_handler.arn

  memory_size = 128
  timeout     = 15

  environment {
    variables = {
      DYNAMODB_TABLE_NAME = aws_dynamodb_table.signage_app.name
      NAME_PREFIX         = local.signage_app.name_prefix
      TENANT              = "default"
    }
  }

  depends_on = [aws_cloudwatch_log_group.signage_app_iot_handler]
}

resource "aws_lambda_permission" "signage_app_iot_handler_iot" {
  function_name = aws_lambda_function.signage_app_iot_handler.function_name
  statement_id  = "iot"
  action        = "lambda:InvokeFunction"
  principal     = "iot.amazonaws.com"
}

resource "aws_iot_topic_rule" "signage_app_iot_handler" {
  name        = replace("${local.signage_app.name_prefix}-iot-handler-0", "-", "_")
  description = "iot-handler"
  enabled     = true
  sql         = "SELECT *, topic() as topic FROM '${local.signage_app.name_prefix}/downlink/#'"
  sql_version = "2016-03-23"

  lambda {
    function_arn = aws_lambda_function.signage_app_iot_handler.arn
  }
}

resource "aws_lambda_function" "signage_app_dev_iot_handler" {
  function_name = "${local.signage_app_dev.name_prefix}-iot-handler"

  filename         = data.archive_file.signage_app_iot_handler.output_path
  source_code_hash = data.archive_file.signage_app_iot_handler.output_base64sha256
  handler          = "iot_handler.handle"
  runtime          = "ruby3.4"
  architectures    = ["arm64"]

  role = aws_iam_role.signage_app_dev_iot_handler.arn

  memory_size = 128
  timeout     = 15

  environment {
    variables = {
      DYNAMODB_TABLE_NAME = aws_dynamodb_table.signage_app_dev.name
      NAME_PREFIX         = local.signage_app_dev.name_prefix
      TENANT              = "default"
    }
  }

  depends_on = [aws_cloudwatch_log_group.signage_app_dev_iot_handler]
}

resource "aws_lambda_permission" "signage_app_dev_iot_handler_iot" {
  function_name = aws_lambda_function.signage_app_dev_iot_handler.function_name
  statement_id  = "iot"
  action        = "lambda:InvokeFunction"
  principal     = "iot.amazonaws.com"
}

resource "aws_iot_topic_rule" "signage_app_dev_iot_handler" {
  name        = replace("${local.signage_app_dev.name_prefix}-iot-handler-0", "-", "_")
  description = "iot-handler"
  enabled     = true
  sql         = "SELECT *, topic() as topic FROM '${local.signage_app_dev.name_prefix}/downlink/#'"
  sql_version = "2016-03-23"

  lambda {
    function_arn = aws_lambda_function.signage_app_dev_iot_handler.arn
  }
}
