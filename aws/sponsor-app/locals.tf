locals {
  default_environments_for_production = {
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
    S3_FILES_REGION          = "ap-northeast-1"
    S3_FILES_ROLE            = aws_iam_role.sponsor_app_user.arn
    SENTRY_ENV               = "production"
    JOB_ADAPTER              = "lambdakiq"

    SSM_SECRET__DATABASE_URL              = aws_ssm_parameter.sponsor_app_database_url.arn
    SSM_SECRET__GITHUB_APP_ID             = aws_ssm_parameter.sponsor_app_github_app_id.arn
    SSM_SECRET__GITHUB_CLIENT_ID          = aws_ssm_parameter.sponsor_app_github_client_id.arn
    SSM_SECRET__GITHUB_CLIENT_PRIVATE_KEY = aws_ssm_parameter.sponsor_app_github_client_private_key.arn
    SSM_SECRET__GITHUB_CLIENT_SECRET      = aws_ssm_parameter.sponsor_app_github_client_secret.arn
    SSM_SECRET__GITHUB_REPO               = aws_ssm_parameter.sponsor_app_github_repo.arn
    SSM_SECRET__GOOGLE_CLOUD_CREDENTIALS  = aws_ssm_parameter.sponsor_app_google_cloud_credentials.arn
    SSM_SECRET__MAILGUN_API_KEY           = aws_ssm_parameter.sponsor_app_mailgun_api_key.arn
    SSM_SECRET__MAILGUN_SMTP_LOGIN        = aws_ssm_parameter.sponsor_app_mailgun_smtp_login.arn
    SSM_SECRET__MAILGUN_SMTP_PASSWORD     = aws_ssm_parameter.sponsor_app_mailgun_smtp_password.arn
    SSM_SECRET__MAILGUN_SMTP_PORT         = aws_ssm_parameter.sponsor_app_mailgun_smtp_port.arn
    SSM_SECRET__REDIS_TLS_URL             = aws_ssm_parameter.sponsor_app_redis_tls_url.arn
    SSM_SECRET__REDIS_URL                 = aws_ssm_parameter.sponsor_app_redis_url.arn
    SSM_SECRET__S3_FILES_BUCKET           = aws_ssm_parameter.sponsor_app_s3_files_bucket.arn
    SSM_SECRET__SECRET_KEY_BASE           = aws_ssm_parameter.sponsor_app_secret_key_base.arn
    SSM_SECRET__SENTRY_DSN                = aws_ssm_parameter.sponsor_app_sentry_dsn.arn
    SSM_SECRET__SLACK_WEBHOOK_URL         = aws_ssm_parameter.sponsor_app_slack_webhook_url.arn
    SSM_SECRET__TITO_API_TOKEN            = aws_ssm_parameter.sponsor_app_tito_api_token.arn
  }

  default_environments_for_staging = {
    DEFAULT_EMAIL_ADDRESS    = "sponsorships-staging@kaigionrails.org"
    DEFAULT_EMAIL_HOST       = "sponsorships-staging.kaigionrails.org"
    DEFAULT_URL_HOST         = "sponsorships-staging.kaigionrails.org"
    LANG                     = "en_US.UTF-8"
    MAILGUN_SMTP_SERVER      = "smtp.mailgun.org"
    ORG_NAME                 = "Kaigi on Rails (staging)"
    RACK_ENV                 = "production"
    RAILS_ENV                = "production"
    RAILS_LOG_TO_STDOUT      = "enabled"
    RAILS_SERVE_STATIC_FILES = "enabled"
    S3_FILES_REGION          = "ap-northeast-1"
    S3_FILES_ROLE            = aws_iam_role.sponsor_app_staging_user.arn
    SENTRY_ENV               = "staging"
    JOB_ADAPTER              = "lambdakiq"

    SSM_SECRET__DATABASE_URL              = aws_ssm_parameter.sponsor_app_staging_database_url.arn
    SSM_SECRET__GITHUB_APP_ID             = aws_ssm_parameter.sponsor_app_staging_github_app_id.arn
    SSM_SECRET__GITHUB_CLIENT_ID          = aws_ssm_parameter.sponsor_app_staging_github_client_id.arn
    SSM_SECRET__GITHUB_CLIENT_PRIVATE_KEY = aws_ssm_parameter.sponsor_app_staging_github_client_private_key.arn
    SSM_SECRET__GITHUB_CLIENT_SECRET      = aws_ssm_parameter.sponsor_app_staging_github_client_secret.arn
    SSM_SECRET__GITHUB_REPO               = aws_ssm_parameter.sponsor_app_staging_github_repo.arn
    SSM_SECRET__GOOGLE_CLOUD_CREDENTIALS  = aws_ssm_parameter.sponsor_app_staging_google_cloud_credentials.arn
    SSM_SECRET__MAILGUN_API_KEY           = aws_ssm_parameter.sponsor_app_staging_mailgun_api_key.arn
    SSM_SECRET__MAILGUN_SMTP_LOGIN        = aws_ssm_parameter.sponsor_app_staging_mailgun_smtp_login.arn
    SSM_SECRET__MAILGUN_SMTP_PASSWORD     = aws_ssm_parameter.sponsor_app_staging_mailgun_smtp_password.arn
    SSM_SECRET__MAILGUN_SMTP_PORT         = aws_ssm_parameter.sponsor_app_staging_mailgun_smtp_port.arn
    SSM_SECRET__REDIS_TLS_URL             = aws_ssm_parameter.sponsor_app_staging_redis_tls_url.arn
    SSM_SECRET__REDIS_URL                 = aws_ssm_parameter.sponsor_app_staging_redis_url.arn
    SSM_SECRET__S3_FILES_BUCKET           = aws_ssm_parameter.sponsor_app_staging_s3_files_bucket.arn
    SSM_SECRET__S3_FILES_PREFIX           = aws_ssm_parameter.sponsor_app_staging_s3_files_prefix.arn
    SSM_SECRET__SECRET_KEY_BASE           = aws_ssm_parameter.sponsor_app_staging_secret_key_base.arn
    SSM_SECRET__SENTRY_DSN                = aws_ssm_parameter.sponsor_app_staging_sentry_dsn.arn
    SSM_SECRET__SLACK_WEBHOOK_URL         = aws_ssm_parameter.sponsor_app_staging_slack_webhook_url.arn
    SSM_SECRET__TITO_API_TOKEN            = aws_ssm_parameter.sponsor_app_staging_tito_api_token.arn
  }
}
