resource "aws_ssm_parameter" "cfp_app_database_url" {
  provider = aws.usw2
  name     = "/cfp-app/DATABASE_URL"
  type     = "SecureString"
  value    = "DATABASE_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "cfp_app_github_key" {
  provider = aws.usw2
  name     = "/cfp-app/GITHUB_KEY"
  type     = "SecureString"
  value    = "GITHUB_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "cfp_app_github_secret" {
  provider = aws.usw2
  name     = "/cfp-app/GITHUB_SECRET"
  type     = "SecureString"
  value    = "GITHUB_SECRET"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "cfp_app_redis_tls_url" {
  provider = aws.usw2
  name     = "/cfp-app/REDIS_TLS_URL"
  type     = "SecureString"
  value    = "REDIS_TLS_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "cfp_app_redis_url" {
  provider = aws.usw2
  name     = "/cfp-app/REDIS_URL"
  type     = "SecureString"
  value    = "REDIS_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "cfp_app_secret_key_base" {
  provider = aws.usw2
  name     = "/cfp-app/SECRET_KEY_BASE"
  type     = "SecureString"
  value    = "SECRET_KEY_BASE"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "cfp_app_sentry_dsn" {
  provider = aws.usw2
  name     = "/cfp-app/SENTRY_DSN"
  type     = "SecureString"
  value    = "SENTRY_DSN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "cfp_app_slack_webhook_url" {
  provider = aws.usw2
  name     = "/cfp-app/SLACK_WEBHOOK_URL"
  type     = "SecureString"
  value    = "SLACK_WEBHOOK_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "cfp_app_smtp_address" {
  provider = aws.usw2
  name     = "/cfp-app/SMTP_ADDRESS"
  type     = "SecureString"
  value    = "SMTP_ADDRESS"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "cfp_app_smtp_domain" {
  provider = aws.usw2
  name     = "/cfp-app/SMTP_DOMAIN"
  type     = "SecureString"
  value    = "SMTP_DOMAIN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "cfp_app_smtp_password" {
  provider = aws.usw2
  name     = "/cfp-app/SMTP_PASSWORD"
  type     = "SecureString"
  value    = "SMTP_PASSWORD"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "cfp_app_smtp_username" {
  provider = aws.usw2
  name     = "/cfp-app/SMTP_USERNAME"
  type     = "SecureString"
  value    = "SMTP_USERNAME"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "cfp_app_twitter_key" {
  provider = aws.usw2
  name     = "/cfp-app/TWITTER_KEY"
  type     = "SecureString"
  value    = "TWITTER_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "cfp_app_twitter_secret" {
  provider = aws.usw2
  name     = "/cfp-app/TWITTER_SECRET"
  type     = "SecureString"
  value    = "TWITTER_SECRET"
  lifecycle {
    ignore_changes = [value]
  }
}

