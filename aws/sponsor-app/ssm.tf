resource "aws_ssm_parameter" "sponsor_app_database_url" {
  provider = aws.usw2
  name     = "/sponsor-app/DATABASE_URL"
  type     = "SecureString"
  value    = "DATABASE_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_github_app_id" {
  provider = aws.usw2
  name     = "/sponsor-app/GITHUB_APP_ID"
  type     = "SecureString"
  value    = "GITHUB_APP_ID"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_github_client_id" {
  provider = aws.usw2
  name     = "/sponsor-app/GITHUB_CLIENT_ID"
  type     = "SecureString"
  value    = "GITHUB_CLIENT_ID"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_github_client_private_key" {
  provider = aws.usw2
  name     = "/sponsor-app/GITHUB_CLIENT_PRIVATE_KEY"
  type     = "SecureString"
  value    = "GITHUB_CLIENT_PRIVATE_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_github_client_secret" {
  provider = aws.usw2
  name     = "/sponsor-app/GITHUB_CLIENT_SECRET"
  type     = "SecureString"
  value    = "GITHUB_CLIENT_SECRET"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_github_repo" {
  provider = aws.usw2
  name     = "/sponsor-app/GITHUB_REPO"
  type     = "SecureString"
  value    = "GITHUB_REPO"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_google_cloud_credentials" {
  provider = aws.usw2
  name     = "/sponsor-app/GOOGLE_CLOUD_CREDENTIALS"
  type     = "SecureString"
  value    = "GOOGLE_CLOUD_CREDENTIALS"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_mailgun_api_key" {
  provider = aws.usw2
  name     = "/sponsor-app/MAILGUN_API_KEY"
  type     = "SecureString"
  value    = "MAILGUN_API_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_mailgun_smtp_login" {
  provider = aws.usw2
  name     = "/sponsor-app/MAILGUN_SMTP_LOGIN"
  type     = "SecureString"
  value    = "MAILGUN_SMTP_LOGIN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_mailgun_smtp_password" {
  provider = aws.usw2
  name     = "/sponsor-app/MAILGUN_SMTP_PASSWORD"
  type     = "SecureString"
  value    = "MAILGUN_SMTP_PASSWORD"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_mailgun_smtp_port" {
  provider = aws.usw2
  name     = "/sponsor-app/MAILGUN_SMTP_PORT"
  type     = "SecureString"
  value    = "MAILGUN_SMTP_PORT"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_redis_tls_url" {
  provider = aws.usw2
  name     = "/sponsor-app/REDIS_TLS_URL"
  type     = "SecureString"
  value    = "REDIS_TLS_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_redis_url" {
  provider = aws.usw2
  name     = "/sponsor-app/REDIS_URL"
  type     = "SecureString"
  value    = "REDIS_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_s3_files_bucket" {
  provider = aws.usw2
  name     = "/sponsor-app/S3_FILES_BUCKET"
  type     = "SecureString"
  value    = "S3_FILES_BUCKET"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_secret_key_base" {
  provider = aws.usw2
  name     = "/sponsor-app/SECRET_KEY_BASE"
  type     = "SecureString"
  value    = "SECRET_KEY_BASE"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_sentry_dsn" {
  provider = aws.usw2
  name     = "/sponsor-app/SENTRY_DSN"
  type     = "SecureString"
  value    = "SENTRY_DSN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_slack_webhook_url" {
  provider = aws.usw2
  name     = "/sponsor-app/SLACK_WEBHOOK_URL"
  type     = "SecureString"
  value    = "SLACK_WEBHOOK_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_tito_api_token" {
  provider = aws.usw2
  name     = "/sponsor-app/TITO_API_TOKEN"
  type     = "SecureString"
  value    = "TITO_API_TOKEN"
  lifecycle {
    ignore_changes = [value]
  }
}

# staging
resource "aws_ssm_parameter" "sponsor_app_staging_database_url" {
  provider = aws.usw2
  name     = "/sponsor-app-staging/DATABASE_URL"
  type     = "SecureString"
  value    = "DATABASE_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_staging_github_app_id" {
  provider = aws.usw2
  name     = "/sponsor-app-staging/GITHUB_APP_ID"
  type     = "SecureString"
  value    = "GITHUB_APP_ID"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_staging_github_client_id" {
  provider = aws.usw2
  name     = "/sponsor-app-staging/GITHUB_CLIENT_ID"
  type     = "SecureString"
  value    = "GITHUB_CLIENT_ID"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_staging_github_client_private_key" {
  provider = aws.usw2
  name     = "/sponsor-app-staging/GITHUB_CLIENT_PRIVATE_KEY"
  type     = "SecureString"
  value    = "GITHUB_CLIENT_PRIVATE_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_staging_github_client_secret" {
  provider = aws.usw2
  name     = "/sponsor-app-staging/GITHUB_CLIENT_SECRET"
  type     = "SecureString"
  value    = "GITHUB_CLIENT_SECRET"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_staging_github_repo" {
  provider = aws.usw2
  name     = "/sponsor-app-staging/GITHUB_REPO"
  type     = "SecureString"
  value    = "GITHUB_REPO"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_staging_google_cloud_credentials" {
  provider = aws.usw2
  name     = "/sponsor-app-staging/GOOGLE_CLOUD_CREDENTIALS"
  type     = "SecureString"
  value    = "GOOGLE_CLOUD_CREDENTIALS"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_staging_mailgun_api_key" {
  provider = aws.usw2
  name     = "/sponsor-app-staging/MAILGUN_API_KEY"
  type     = "SecureString"
  value    = "MAILGUN_API_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_staging_mailgun_smtp_login" {
  provider = aws.usw2
  name     = "/sponsor-app-staging/MAILGUN_SMTP_LOGIN"
  type     = "SecureString"
  value    = "MAILGUN_SMTP_LOGIN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_staging_mailgun_smtp_password" {
  provider = aws.usw2
  name     = "/sponsor-app-staging/MAILGUN_SMTP_PASSWORD"
  type     = "SecureString"
  value    = "MAILGUN_SMTP_PASSWORD"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_staging_mailgun_smtp_port" {
  provider = aws.usw2
  name     = "/sponsor-app-staging/MAILGUN_SMTP_PORT"
  type     = "SecureString"
  value    = "MAILGUN_SMTP_PORT"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_staging_redis_tls_url" {
  provider = aws.usw2
  name     = "/sponsor-app-staging/REDIS_TLS_URL"
  type     = "SecureString"
  value    = "REDIS_TLS_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_staging_redis_url" {
  provider = aws.usw2
  name     = "/sponsor-app-staging/REDIS_URL"
  type     = "SecureString"
  value    = "REDIS_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_staging_s3_files_bucket" {
  provider = aws.usw2
  name     = "/sponsor-app-staging/S3_FILES_BUCKET"
  type     = "SecureString"
  value    = "S3_FILES_BUCKET"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_staging_secret_key_base" {
  provider = aws.usw2
  name     = "/sponsor-app-staging/SECRET_KEY_BASE"
  type     = "SecureString"
  value    = "SECRET_KEY_BASE"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_staging_sentry_dsn" {
  provider = aws.usw2
  name     = "/sponsor-app-staging/SENTRY_DSN"
  type     = "SecureString"
  value    = "SENTRY_DSN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_staging_slack_webhook_url" {
  provider = aws.usw2
  name     = "/sponsor-app-staging/SLACK_WEBHOOK_URL"
  type     = "SecureString"
  value    = "SLACK_WEBHOOK_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sponsor_app_staging_tito_api_token" {
  provider = aws.usw2
  name     = "/sponsor-app-staging/TITO_API_TOKEN"
  type     = "SecureString"
  value    = "TITO_API_TOKEN"
  lifecycle {
    ignore_changes = [value]
  }
}
