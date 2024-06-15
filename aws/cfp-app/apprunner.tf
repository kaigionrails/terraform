resource "aws_apprunner_service" "cfp_app" {
  provider     = aws.usw2
  service_name = "cfp-app"

  source_configuration {
    image_repository {
      image_configuration {
        port = "3000"

        # See also kaigionrails/cfp-app/deploy/task_definition.jsonnet
        runtime_environment_variables = {
          AWS_ACCESS_KEY_ID        = "sample"
          AWS_S3_BUCKET            = "sample"
          AWS_SECRET_ACCESS_KEY    = "sample"
          LANG                     = "en_US.UTF-8"
          RACK_ENV                 = "production"
          RAILS_ENV                = "production"
          RAILS_LOG_TO_STDOUT      = "enabled"
          RAILS_SERVE_STATIC_FILES = "enabled"
          TIMEZONE                 = "Asia/Tokyo"
        }

        # See also kaigionrails/cfp-app/deploy/task_definition.jsonnet
        runtime_environment_secrets = {
          DATABASE_URL      = aws_ssm_parameter.cfp_app_database_url.arn
          GITHUB_KEY        = aws_ssm_parameter.cfp_app_github_key.arn
          GITHUB_SECRET     = aws_ssm_parameter.cfp_app_github_secret.arn
          REDIS_TLS_URL     = aws_ssm_parameter.cfp_app_redis_tls_url.arn
          REDIS_URL         = aws_ssm_parameter.cfp_app_redis_url.arn
          SECRET_KEY_BASE   = aws_ssm_parameter.cfp_app_secret_key_base.arn
          SLACK_WEBHOOK_URL = aws_ssm_parameter.cfp_app_slack_webhook_url.arn
          SMTP_ADDRESS      = aws_ssm_parameter.cfp_app_smtp_address.arn
          SMTP_DOMAIN       = aws_ssm_parameter.cfp_app_smtp_domain.arn
          SMTP_USERNAME     = aws_ssm_parameter.cfp_app_smtp_username.arn
          SMTP_PASSWORD     = aws_ssm_parameter.cfp_app_smtp_password.arn
          TWITTER_KEY       = aws_ssm_parameter.cfp_app_twitter_key.arn
          TWITTER_SECRET    = aws_ssm_parameter.cfp_app_twitter_secret.arn
        }

        # start_command = "bundle exec puma -C config/puma.rb"
      }
      image_identifier      = "${aws_ecr_repository.cfp_app.repository_url}:latest"
      image_repository_type = "ECR"
    }
    auto_deployments_enabled = false

    authentication_configuration {
      access_role_arn = aws_iam_role.cfp_app_apprunner.arn
    }
  }

  instance_configuration {
    cpu               = 256
    memory            = 512
    instance_role_arn = aws_iam_role.cfp_app.arn
  }

  health_check_configuration {
    protocol            = "TCP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 5
  }

  lifecycle {
    ignore_changes = [source_configuration[0].image_repository[0].image_identifier]
  }
}

resource "aws_iam_role" "cfp_app_apprunner" {
  name               = "CfpAppAppRunner"
  description        = "CfpAppAppRunner"
  assume_role_policy = data.aws_iam_policy_document.cfp_app_apprunner_trust.json
}

data "aws_iam_policy_document" "cfp_app_apprunner_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "build.apprunner.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role_policy" "cfp_app_apprunner" {
  role   = aws_iam_role.cfp_app_apprunner.name
  policy = data.aws_iam_policy_document.cfp_app_apprunner.json
}

data "aws_iam_policy_document" "cfp_app_apprunner" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "sts:GetServiceBearerToken",
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
    ]
    resources = [aws_ecr_repository.cfp_app.arn]
  }
}

resource "aws_apprunner_custom_domain_association" "cfp_app" {
  provider    = aws.usw2
  service_arn = aws_apprunner_service.cfp_app.arn
  domain_name = "cfp.kaigionrails.org"
}
