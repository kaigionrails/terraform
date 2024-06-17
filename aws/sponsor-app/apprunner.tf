resource "aws_apprunner_service" "sponsor_app" {
  provider     = aws.usw2
  service_name = "sponsor-app"

  source_configuration {
    image_repository {
      image_configuration {
        port = "3000"

        # See also kaigionrails/sponsor-app/deploy/task_definition.jsonnet
        runtime_environment_variables = {
          AWS_ACCESS_KEY_ID        = "sample"
          AWS_REGION               = "ap-northeast-1"
          AWS_SECRET_ACCESS_KEY    = "sample"
          DEFAULT_EMAIL_ADDRESS    = "sponsorships@kaigionrails.org"
          DEFAULT_EMAIL_HOST       = "sponsorships.kaigionrails.org"
          DEFAULT_URL_HOST         = "sponsorships.kaigionrails.org"
          LANG                     = "en_US.UTF-8"
          MAILGUN_SMTP_SERVER      = "smtp.mailgun.org"
          ORG_NAME                 = "Kaigi on Rails"
          RACK_ENV                 = "production"
          RAILS_ENV                = "production"
          RAILS_LOG_TO_STDOUT      = "enabled"
          RAILS_SERVE_STATIC_FILES = "enabled"
          SENTRY_ENV               = "production"
        }

        # See also kaigionrails/sponsor-app/deploy/task_definition.jsonnet
        runtime_environment_secrets = {
          DATABASE_URL              = aws_ssm_parameter.sponsor_app_database_url.arn
          GITHUB_APP_ID             = aws_ssm_parameter.sponsor_app_github_app_id.arn
          GITHUB_CLIENT_ID          = aws_ssm_parameter.sponsor_app_github_client_id.arn
          GITHUB_CLIENT_PRIVATE_KEY = aws_ssm_parameter.sponsor_app_github_client_private_key.arn
          GITHUB_CLIENT_SECRET      = aws_ssm_parameter.sponsor_app_github_client_secret.arn
          GITHUB_REPO               = aws_ssm_parameter.sponsor_app_github_repo.arn
          GOOGLE_CLOUD_CREDENTIALS  = aws_ssm_parameter.sponsor_app_google_cloud_credentials.arn
          MAILGUN_API_KEY           = aws_ssm_parameter.sponsor_app_mailgun_api_key.arn
          MAILGUN_SMTP_LOGIN        = aws_ssm_parameter.sponsor_app_mailgun_smtp_login.arn
          MAILGUN_SMTP_PASSWORD     = aws_ssm_parameter.sponsor_app_mailgun_smtp_password.arn
          MAILGUN_SMTP_PORT         = aws_ssm_parameter.sponsor_app_mailgun_smtp_port.arn
          REDIS_TLS_URL             = aws_ssm_parameter.sponsor_app_redis_tls_url.arn
          REDIS_URL                 = aws_ssm_parameter.sponsor_app_redis_url.arn
          S3_FILES_BUCKET           = aws_ssm_parameter.sponsor_app_s3_files_bucket.arn
          SECRET_KEY_BASE           = aws_ssm_parameter.sponsor_app_secret_key_base.arn
          SENTRY_DSN                = aws_ssm_parameter.sponsor_app_sentry_dsn.arn
          SLACK_WEBHOOK_URL         = aws_ssm_parameter.sponsor_app_slack_webhook_url.arn
          TITO_API_TOKEN            = aws_ssm_parameter.sponsor_app_tito_api_token.arn
        }

        # start_command = "bundle exec puma -C config/puma.rb"
      }
      image_identifier      = "${aws_ecr_repository.sponsor_app.repository_url}:latest"
      image_repository_type = "ECR"
    }
    auto_deployments_enabled = false

    authentication_configuration {
      access_role_arn = aws_iam_role.sponsor_app_apprunner.arn
    }
  }

  instance_configuration {
    cpu               = 256
    memory            = 512
    instance_role_arn = aws_iam_role.sponsor_app.arn
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

resource "aws_iam_role" "sponsor_app_apprunner" {
  name               = "SponsorAppAppRunner"
  description        = "SponsorAppAppRunner"
  assume_role_policy = data.aws_iam_policy_document.sponsor_app_apprunner_trust.json
}

data "aws_iam_policy_document" "sponsor_app_apprunner_trust" {
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

resource "aws_iam_role_policy" "sponsor_app_apprunner" {
  role   = aws_iam_role.sponsor_app_apprunner.name
  policy = data.aws_iam_policy_document.sponsor_app_apprunner.json
}

data "aws_iam_policy_document" "sponsor_app_apprunner" {
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
    resources = [aws_ecr_repository.sponsor_app.arn]
  }
}

resource "aws_apprunner_custom_domain_association" "sponsor_app" {
  provider    = aws.usw2
  service_arn = aws_apprunner_service.sponsor_app.arn
  domain_name = "sponsorships.kaigionrails.org"
}
