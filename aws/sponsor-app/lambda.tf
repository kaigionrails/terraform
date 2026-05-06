resource "aws_lambda_function" "sponsor_app_web" {
  function_name = "sponsor-app-web-production"

  package_type  = "Image"
  architectures = ["x86_64"]
  image_uri     = "${aws_ecr_repository.sponsor_app_apne1.repository_url}:latest"
  image_config {
    entry_point = ["/lambda_entrypoint.sh"]
  }

  role = aws_iam_role.sponsor_app.arn

  memory_size = 1024
  timeout     = 90

  environment {
    variables = merge(local.default_environments_for_production, {
      APP_HANDLER     = "config/lambda_rack.LambdaRackApp.handle"
      LAMBDAKIQ_QUEUE = aws_sqs_queue.sponsor_app_lambdakiq.name
    })
  }

  lifecycle {
    ignore_changes = [
      image_uri,
    ]
  }
}

resource "aws_lambda_function" "sponsor_app_lambdakiq" {
  function_name = "sponsor-app-lambdakiq-production"

  package_type  = "Image"
  architectures = ["x86_64"]
  image_uri     = "${aws_ecr_repository.sponsor_app_apne1.repository_url}:latest"
  image_config {
    entry_point = ["/lambda_entrypoint.sh"]
  }

  role = aws_iam_role.sponsor_app.arn

  memory_size = 1024
  timeout     = 90

  environment {
    variables = merge(local.default_environments_for_production, {
      APP_HANDLER     = "config/environment.Lambdakiq.cmd"
      LAMBDAKIQ_QUEUE = aws_sqs_queue.sponsor_app_lambdakiq.name
    })
  }

  lifecycle {
    ignore_changes = [
      image_uri,
    ]
  }
}

resource "aws_lambda_event_source_mapping" "lambdakiq" {
  event_source_arn        = aws_sqs_queue.sponsor_app_lambdakiq.arn
  function_name           = aws_lambda_function.sponsor_app_lambdakiq.arn
  batch_size              = 1
  function_response_types = ["ReportBatchItemFailures"]
}

resource "aws_lambda_function" "sponsor_app_runner" {
  function_name = "sponsor-app-runner-production"

  package_type  = "Image"
  architectures = ["x86_64"]
  image_uri     = "${aws_ecr_repository.sponsor_app_apne1.repository_url}:latest"
  image_config {
    entry_point = ["/lambda_entrypoint.sh"]
  }

  role = aws_iam_role.sponsor_app.arn

  memory_size = 2048
  timeout     = 90

  environment {
    variables = merge(local.default_environments_for_production, {
      APP_HANDLER     = "config/lambda_rack.LambdaRackApp.handle"
      LAMBDAKIQ_QUEUE = aws_sqs_queue.sponsor_app_lambdakiq.name
    })
  }

  lifecycle {
    ignore_changes = [
      image_uri,
    ]
  }
}

resource "aws_lambda_function" "sponsor_app_web_staging" {
  function_name = "sponsor-app-web-staging"

  package_type  = "Image"
  architectures = ["x86_64"]
  image_uri     = "${aws_ecr_repository.sponsor_app_apne1.repository_url}:latest"
  image_config {
    entry_point = ["/lambda_entrypoint.sh"]
  }

  role = aws_iam_role.sponsor_app.arn

  memory_size = 1024
  timeout     = 90

  environment {
    variables = merge(local.default_environments_for_staging, {
      APP_HANDLER     = "config/lambda_rack.LambdaRackApp.handle"
      LAMBDAKIQ_QUEUE = aws_sqs_queue.sponsor_app_lambdakiq_staging.name
    })
  }

  lifecycle {
    ignore_changes = [
      image_uri,
    ]
  }
}

resource "aws_lambda_function" "sponsor_app_lambdakiq_staging" {
  function_name = "sponsor-app-lambdakiq-staging"

  package_type  = "Image"
  architectures = ["x86_64"]
  image_uri     = "${aws_ecr_repository.sponsor_app_apne1.repository_url}:latest"
  image_config {
    entry_point = ["/lambda_entrypoint.sh"]
  }

  role = aws_iam_role.sponsor_app.arn

  memory_size = 1024
  timeout     = 90

  environment {
    variables = merge(local.default_environments_for_staging, {
      APP_HANDLER     = "config/environment.Lambdakiq.cmd"
      LAMBDAKIQ_QUEUE = aws_sqs_queue.sponsor_app_lambdakiq_staging.name
    })
  }

  lifecycle {
    ignore_changes = [
      image_uri,
    ]
  }
}

resource "aws_lambda_event_source_mapping" "lambdakiq_staging" {
  event_source_arn        = aws_sqs_queue.sponsor_app_lambdakiq_staging.arn
  function_name           = aws_lambda_function.sponsor_app_lambdakiq_staging.arn
  batch_size              = 1
  function_response_types = ["ReportBatchItemFailures"]
}

resource "aws_lambda_function" "sponsor_app_runner_staging" {
  function_name = "sponsor-app-runner-staging"

  package_type  = "Image"
  architectures = ["x86_64"]
  image_uri     = "${aws_ecr_repository.sponsor_app_apne1.repository_url}:latest"
  image_config {
    entry_point = ["/lambda_entrypoint.sh"]
  }

  role = aws_iam_role.sponsor_app.arn

  memory_size = 2048
  timeout     = 90

  environment {
    variables = merge(local.default_environments_for_staging, {
      APP_HANDLER     = "config/lambda_rack.LambdaRackApp.handle"
      LAMBDAKIQ_QUEUE = aws_sqs_queue.sponsor_app_lambdakiq_staging.name
    })
  }

  lifecycle {
    ignore_changes = [
      image_uri,
    ]
  }
}
