resource "aws_apprunner_service" "conference_app" {
  provider     = aws.usw2
  service_name = "conference-app"

  source_configuration {
    image_repository {
      image_configuration {
        port = "3000"

        # See also kaigionrails/conference-app/deploy/task_definition.jsonnet
        runtime_environment_variables = {
          APPLICATION_URL           = "https://app.kaigionrails.org"
          GITHUB_OAUTH_REDIRECT_URI = "https://app.kaigionrails.org/auth/github/callback"
          LANG                      = "en_US.UTF-8"
          RACK_ENV                  = "production"
          RAILS_ENV                 = "production"
          RAILS_LOG_TO_STDOUT       = "enabled"
          RAILS_SERVE_STATIC_FILES  = "enabled"
          SCOUT_NAME                = "conference-app"
          SENTRY_ENV                = "production"
          VAPID_SUBJECT_MAILTO      = "mailto:info@kaigionrails.org"
        }

        # See also kaigionrails/conference-app/deploy/task_definition.jsonnet
        runtime_environment_secrets = {
          CLOUDFLARE_ACCESS_KEY_ID     = aws_ssm_parameter.conference_app_cloudflare_access_key_id.arn
          CLOUDFLARE_ACCOUNT_ID        = aws_ssm_parameter.conference_app_cloudflare_account_id.arn
          CLOUDFLARE_API_TOKEN         = aws_ssm_parameter.conference_app_cloudflare_api_token.arn
          CLOUDFLARE_SECRET_ACCESS_KEY = aws_ssm_parameter.conference_app_cloudflare_secret_access_key.arn
          CLOUDFLARE_R2_BUCKET_NAME    = aws_ssm_parameter.conference_app_cloudflare_r2_bucket_name.arn
          CLOUDFLARE_R2_ENDPOINT       = aws_ssm_parameter.conference_app_cloudflare_r2_endpoint.arn
          DATABASE_URL                 = aws_ssm_parameter.conference_app_database_url.arn
          GITHUB_APP_ID                = aws_ssm_parameter.conference_app_github_app_id.arn
          GITHUB_KEY                   = aws_ssm_parameter.conference_app_github_key.arn
          GITHUB_PRIVATE_KEY           = aws_ssm_parameter.conference_app_github_private_key.arn
          GITHUB_SECRET                = aws_ssm_parameter.conference_app_github_secret.arn
          REDIS_TLS_URL                = aws_ssm_parameter.conference_app_redis_tls_url.arn
          REDIS_URL                    = aws_ssm_parameter.conference_app_redis_url.arn
          SCOUT_KEY                    = aws_ssm_parameter.conference_app_scout_key.arn
          SECRET_KEY_BASE              = aws_ssm_parameter.conference_app_secret_key_base.arn
          SENTRY_DSN                   = aws_ssm_parameter.conference_app_sentry_dsn.arn
          TITO_ACCOUNT_SLUG            = aws_ssm_parameter.conference_app_tito_account_slug.arn
          TITO_API_TOKEN               = aws_ssm_parameter.conference_app_tito_api_token.arn
          TITO_WEBHOOK_SECRET          = aws_ssm_parameter.conference_app_tito_webhook_secret.arn
          VAPID_PRIVATE_KEY            = aws_ssm_parameter.conference_app_vapid_private_key.arn
          VAPID_PUBLIC_KEY             = aws_ssm_parameter.conference_app_vapid_public_key.arn
        }

        # start_command = "bundle exec puma -C config/puma.rb"
      }
      image_identifier      = "${aws_ecr_repository.conference_app.repository_url}:latest"
      image_repository_type = "ECR"
    }
    auto_deployments_enabled = false

    authentication_configuration {
      access_role_arn = aws_iam_role.conference_app_apprunner.arn
    }
  }

  instance_configuration {
    cpu               = 256
    memory            = 512
    instance_role_arn = aws_iam_role.conference_app.arn
  }

  health_check_configuration {
    protocol            = "HTTP"
    path                = "/up"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 5
  }

  lifecycle {
    ignore_changes = [source_configuration[0].image_repository[0].image_identifier]
  }
}

resource "aws_apprunner_service" "conference_app_staging" {
  provider     = aws.usw2
  service_name = "conference-app-staging"

  source_configuration {
    image_repository {
      image_configuration {
        port = "3000"

        # See also kaigionrails/conference-app/deploy/staging/task_definition.jsonnet
        runtime_environment_variables = {
          APPLICATION_URL           = "https://app-staging.kaigionrails.org"
          GITHUB_OAUTH_REDIRECT_URI = "https://app-staging.kaigionrails.org/auth/github/callback"
          LANG                      = "en_US.UTF-8"
          RACK_ENV                  = "production"
          RAILS_ENV                 = "production"
          RAILS_LOG_TO_STDOUT       = "enabled"
          RAILS_SERVE_STATIC_FILES  = "enabled"
          SCOUT_NAME                = "conference-app-staging"
          SENTRY_ENV                = "staging"
          SHIRATAKI_URL             = "https://shirataki-staging.kaigionrails.org"
          VAPID_SUBJECT_MAILTO      = "mailto:info@kaigionrails.org"
        }

        # See also kaigionrails/conference-app/deploy/staging/task_definition.jsonnet
        runtime_environment_secrets = {
          CLOUDFLARE_ACCESS_KEY_ID     = aws_ssm_parameter.conference_app_staging_cloudflare_access_key_id.arn
          CLOUDFLARE_ACCOUNT_ID        = aws_ssm_parameter.conference_app_staging_cloudflare_account_id.arn
          CLOUDFLARE_API_TOKEN         = aws_ssm_parameter.conference_app_staging_cloudflare_api_token.arn
          CLOUDFLARE_SECRET_ACCESS_KEY = aws_ssm_parameter.conference_app_staging_cloudflare_secret_access_key.arn
          CLOUDFLARE_R2_BUCKET_NAME    = aws_ssm_parameter.conference_app_staging_cloudflare_r2_bucket_name.arn
          CLOUDFLARE_R2_ENDPOINT       = aws_ssm_parameter.conference_app_staging_cloudflare_r2_endpoint.arn
          DATABASE_URL                 = aws_ssm_parameter.conference_app_staging_database_url.arn
          GITHUB_APP_ID                = aws_ssm_parameter.conference_app_staging_github_app_id.arn
          GITHUB_KEY                   = aws_ssm_parameter.conference_app_staging_github_key.arn
          GITHUB_PRIVATE_KEY           = aws_ssm_parameter.conference_app_staging_github_private_key.arn
          GITHUB_SECRET                = aws_ssm_parameter.conference_app_staging_github_secret.arn
          REDIS_TLS_URL                = aws_ssm_parameter.conference_app_staging_redis_tls_url.arn
          REDIS_URL                    = aws_ssm_parameter.conference_app_staging_redis_url.arn
          SCOUT_KEY                    = aws_ssm_parameter.conference_app_staging_scout_key.arn
          SECRET_KEY_BASE              = aws_ssm_parameter.conference_app_staging_secret_key_base.arn
          SENTRY_DSN                   = aws_ssm_parameter.conference_app_staging_sentry_dsn.arn
          TITO_ACCOUNT_SLUG            = aws_ssm_parameter.conference_app_staging_tito_account_slug.arn
          TITO_API_TOKEN               = aws_ssm_parameter.conference_app_staging_tito_api_token.arn
          TITO_WEBHOOK_SECRET          = aws_ssm_parameter.conference_app_staging_tito_webhook_secret.arn
          VAPID_PRIVATE_KEY            = aws_ssm_parameter.conference_app_staging_vapid_private_key.arn
          VAPID_PUBLIC_KEY             = aws_ssm_parameter.conference_app_staging_vapid_public_key.arn
        }

        # start_command = "bundle exec puma -C config/puma.rb"
      }
      image_identifier      = "${aws_ecr_repository.conference_app.repository_url}:latest"
      image_repository_type = "ECR"
    }
    auto_deployments_enabled = false

    authentication_configuration {
      access_role_arn = aws_iam_role.conference_app_apprunner.arn
    }
  }

  instance_configuration {
    cpu               = 256
    memory            = 512
    instance_role_arn = aws_iam_role.conference_app.arn
  }

  health_check_configuration {
    protocol            = "HTTP"
    path                = "/up"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 5
  }

  lifecycle {
    ignore_changes = [source_configuration[0].image_repository[0].image_identifier]
  }
}


resource "aws_iam_role" "conference_app_apprunner" {
  name               = "ConferenceAppAppRunner"
  description        = "ConferenceAppAppRunner"
  assume_role_policy = data.aws_iam_policy_document.conference_app_apprunner_trust.json
}

data "aws_iam_policy_document" "conference_app_apprunner_trust" {
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

resource "aws_iam_role_policy" "conference_app_apprunner" {
  role   = aws_iam_role.conference_app_apprunner.name
  policy = data.aws_iam_policy_document.conference_app_apprunner.json
}

data "aws_iam_policy_document" "conference_app_apprunner" {
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
    resources = [aws_ecr_repository.conference_app.arn]
  }
}

resource "aws_apprunner_custom_domain_association" "conference_app" {
  provider    = aws.usw2
  service_arn = aws_apprunner_service.conference_app.arn
  domain_name = "app.kaigionrails.org"
}

resource "aws_apprunner_custom_domain_association" "conference_app_staging" {
  provider             = aws.usw2
  service_arn          = aws_apprunner_service.conference_app_staging.arn
  domain_name          = "app-staging.kaigionrails.org"
  enable_www_subdomain = false
}
