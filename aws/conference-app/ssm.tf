resource "aws_ssm_parameter" "conference_app_cloudflare_access_key_id" {
  provider = aws.usw2
  name     = "/conference-app/CLOUDFLARE_ACCESS_KEY_ID"
  type     = "SecureString"
  value    = "CLOUDFLARE_ACCESS_KEY_ID"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_cloudflare_account_id" {
  provider = aws.usw2
  name     = "/conference-app/CLOUDFLARE_ACCOUNT_ID"
  type     = "SecureString"
  value    = "CLOUDFLARE_ACCOUNT_ID"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_cloudflare_api_token" {
  provider = aws.usw2
  name     = "/conference-app/CLOUDFLARE_API_TOKEN"
  type     = "SecureString"
  value    = "CLOUDFLARE_API_TOKEN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_cloudflare_secret_access_key" {
  provider = aws.usw2
  name     = "/conference-app/CLOUDFLARE_SECRET_ACCESS_KEY"
  type     = "SecureString"
  value    = "CLOUDFLARE_SECRET_ACCESS_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_cloudflare_r2_bucket_name" {
  provider = aws.usw2
  name     = "/conference-app/CLOUDFLARE_R2_BUCKET_NAME"
  type     = "SecureString"
  value    = "CLOUDFLARE_R2_BUCKET_NAME"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_cloudflare_r2_endpoint" {
  provider = aws.usw2
  name     = "/conference-app/CLOUDFLARE_R2_ENDPOINT"
  type     = "SecureString"
  value    = "CLOUDFLARE_R2_ENDPOINT"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_database_url" {
  provider = aws.usw2
  name     = "/conference-app/DATABASE_URL"
  type     = "SecureString"
  value    = "DATABASE_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_github_app_id" {
  provider = aws.usw2
  name     = "/conference-app/GITHUB_APP_ID"
  type     = "SecureString"
  value    = "GITHUB_APP_ID"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_github_key" {
  provider = aws.usw2
  name     = "/conference-app/GITHUB_KEY"
  type     = "SecureString"
  value    = "GITHUB_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_github_private_key" {
  provider = aws.usw2
  name     = "/conference-app/GITHUB_PRIVATE_KEY"
  type     = "SecureString"
  value    = "GITHUB_PRIVATE_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_github_secret" {
  provider = aws.usw2
  name     = "/conference-app/GITHUB_SECRET"
  type     = "SecureString"
  value    = "GITHUB_SECRET"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_redis_tls_url" {
  provider = aws.usw2
  name     = "/conference-app/REDIS_TLS_URL"
  type     = "SecureString"
  value    = "REDIS_TLS_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_redis_url" {
  provider = aws.usw2
  name     = "/conference-app/REDIS_URL"
  type     = "SecureString"
  value    = "REDIS_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_scout_key" {
  provider = aws.usw2
  name     = "/conference-app/SCOUT_KEY"
  type     = "SecureString"
  value    = "SCOUT_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_secret_key_base" {
  provider = aws.usw2
  name     = "/conference-app/SECRET_KEY_BASE"
  type     = "SecureString"
  value    = "SECRET_KEY_BASE"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_sentry_dsn" {
  provider = aws.usw2
  name     = "/conference-app/SENTRY_DSN"
  type     = "SecureString"
  value    = "SENTRY_DSN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_tito_account_slug" {
  provider = aws.usw2
  name     = "/conference-app/TITO_ACCOUNT_SLUG"
  type     = "SecureString"
  value    = "TITO_ACCOUNT_SLUG"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_tito_api_token" {
  provider = aws.usw2
  name     = "/conference-app/TITO_API_TOKEN"
  type     = "SecureString"
  value    = "TITO_API_TOKEN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_tito_webhook_secret" {
  provider = aws.usw2
  name     = "/conference-app/TITO_WEBHOOK_SECRET"
  type     = "SecureString"
  value    = "TITO_WEBHOOK_SECRET"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_vapid_private_key" {
  provider = aws.usw2
  name     = "/conference-app/VAPID_PRIVATE_KEY"
  type     = "SecureString"
  value    = "VAPID_PRIVATE_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_vapid_public_key" {
  provider = aws.usw2
  name     = "/conference-app/VAPID_PUBLIC_KEY"
  type     = "SecureString"
  value    = "VAPID_PUBLIC_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

############################################################

resource "aws_ssm_parameter" "conference_app_staging_cloudflare_access_key_id" {
  provider = aws.usw2
  name     = "/conference-app-staging/CLOUDFLARE_ACCESS_KEY_ID"
  type     = "SecureString"
  value    = "CLOUDFLARE_ACCESS_KEY_ID"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_cloudflare_account_id" {
  provider = aws.usw2
  name     = "/conference-app-staging/CLOUDFLARE_ACCOUNT_ID"
  type     = "SecureString"
  value    = "CLOUDFLARE_ACCOUNT_ID"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_cloudflare_api_token" {
  provider = aws.usw2
  name     = "/conference-app-staging/CLOUDFLARE_API_TOKEN"
  type     = "SecureString"
  value    = "CLOUDFLARE_API_TOKEN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_cloudflare_secret_access_key" {
  provider = aws.usw2
  name     = "/conference-app-staging/CLOUDFLARE_SECRET_ACCESS_KEY"
  type     = "SecureString"
  value    = "CLOUDFLARE_SECRET_ACCESS_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_cloudflare_r2_bucket_name" {
  provider = aws.usw2
  name     = "/conference-app-staging/CLOUDFLARE_R2_BUCKET_NAME"
  type     = "SecureString"
  value    = "CLOUDFLARE_R2_BUCKET_NAME"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_cloudflare_r2_endpoint" {
  provider = aws.usw2
  name     = "/conference-app-staging/CLOUDFLARE_R2_ENDPOINT"
  type     = "SecureString"
  value    = "CLOUDFLARE_R2_ENDPOINT"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_database_url" {
  provider = aws.usw2
  name     = "/conference-app-staging/DATABASE_URL"
  type     = "SecureString"
  value    = "DATABASE_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_github_app_id" {
  provider = aws.usw2
  name     = "/conference-app-staging/GITHUB_APP_ID"
  type     = "SecureString"
  value    = "GITHUB_APP_ID"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_github_key" {
  provider = aws.usw2
  name     = "/conference-app-staging/GITHUB_KEY"
  type     = "SecureString"
  value    = "GITHUB_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_github_private_key" {
  provider = aws.usw2
  name     = "/conference-app-staging/GITHUB_PRIVATE_KEY"
  type     = "SecureString"
  value    = "GITHUB_PRIVATE_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_github_secret" {
  provider = aws.usw2
  name     = "/conference-app-staging/GITHUB_SECRET"
  type     = "SecureString"
  value    = "GITHUB_SECRET"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_redis_tls_url" {
  provider = aws.usw2
  name     = "/conference-app-staging/REDIS_TLS_URL"
  type     = "SecureString"
  value    = "REDIS_TLS_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_redis_url" {
  provider = aws.usw2
  name     = "/conference-app-staging/REDIS_URL"
  type     = "SecureString"
  value    = "REDIS_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_scout_key" {
  provider = aws.usw2
  name     = "/conference-app-staging/SCOUT_KEY"
  type     = "SecureString"
  value    = "SCOUT_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_secret_key_base" {
  provider = aws.usw2
  name     = "/conference-app-staging/SECRET_KEY_BASE"
  type     = "SecureString"
  value    = "SECRET_KEY_BASE"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_sentry_dsn" {
  provider = aws.usw2
  name     = "/conference-app-staging/SENTRY_DSN"
  type     = "SecureString"
  value    = "SENTRY_DSN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_tito_account_slug" {
  provider = aws.usw2
  name     = "/conference-app-staging/TITO_ACCOUNT_SLUG"
  type     = "SecureString"
  value    = "TITO_ACCOUNT_SLUG"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_tito_api_token" {
  provider = aws.usw2
  name     = "/conference-app-staging/TITO_API_TOKEN"
  type     = "SecureString"
  value    = "TITO_API_TOKEN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_tito_webhook_secret" {
  provider = aws.usw2
  name     = "/conference-app-staging/TITO_WEBHOOK_SECRET"
  type     = "SecureString"
  value    = "TITO_WEBHOOK_SECRET"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_vapid_private_key" {
  provider = aws.usw2
  name     = "/conference-app-staging/VAPID_PRIVATE_KEY"
  type     = "SecureString"
  value    = "VAPID_PRIVATE_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_vapid_public_key" {
  provider = aws.usw2
  name     = "/conference-app-staging/VAPID_PUBLIC_KEY"
  type     = "SecureString"
  value    = "VAPID_PUBLIC_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

#############################################################
## ap-northeast-1

resource "aws_ssm_parameter" "conference_app_active_record_encryption_deterministic_key_apne1" {
  name  = "/conference-app/ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY"
  type  = "SecureString"
  value = "ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_active_record_encryption_key_derivation_salt_apne1" {
  name  = "/conference-app/ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT"
  type  = "SecureString"
  value = "ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_active_record_encryption_primary_key_apne1" {
  name  = "/conference-app/ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY"
  type  = "SecureString"
  value = "ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_cloudflare_access_key_id_apne1" {
  name  = "/conference-app/CLOUDFLARE_ACCESS_KEY_ID"
  type  = "SecureString"
  value = "CLOUDFLARE_ACCESS_KEY_ID"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_cloudflare_account_id_apne1" {
  name  = "/conference-app/CLOUDFLARE_ACCOUNT_ID"
  type  = "SecureString"
  value = "CLOUDFLARE_ACCOUNT_ID"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_cloudflare_api_token_apne1" {
  name  = "/conference-app/CLOUDFLARE_API_TOKEN"
  type  = "SecureString"
  value = "CLOUDFLARE_API_TOKEN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_cloudflare_secret_access_key_apne1" {
  name  = "/conference-app/CLOUDFLARE_SECRET_ACCESS_KEY"
  type  = "SecureString"
  value = "CLOUDFLARE_SECRET_ACCESS_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_cloudflare_r2_bucket_name_apne1" {
  name  = "/conference-app/CLOUDFLARE_R2_BUCKET_NAME"
  type  = "SecureString"
  value = "CLOUDFLARE_R2_BUCKET_NAME"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_cloudflare_r2_endpoint_apne1" {
  name  = "/conference-app/CLOUDFLARE_R2_ENDPOINT"
  type  = "SecureString"
  value = "CLOUDFLARE_R2_ENDPOINT"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_database_url_apne1" {
  name  = "/conference-app/DATABASE_URL"
  type  = "SecureString"
  value = "DATABASE_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_github_app_id_apne1" {
  name  = "/conference-app/GITHUB_APP_ID"
  type  = "SecureString"
  value = "GITHUB_APP_ID"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_github_key_apne1" {
  name  = "/conference-app/GITHUB_KEY"
  type  = "SecureString"
  value = "GITHUB_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_github_private_key_apne1" {
  name  = "/conference-app/GITHUB_PRIVATE_KEY"
  type  = "SecureString"
  value = "GITHUB_PRIVATE_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_github_secret_apne1" {
  name  = "/conference-app/GITHUB_SECRET"
  type  = "SecureString"
  value = "GITHUB_SECRET"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_scout_key_apne1" {
  name  = "/conference-app/SCOUT_KEY"
  type  = "SecureString"
  value = "SCOUT_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_secret_key_base_apne1" {
  name  = "/conference-app/SECRET_KEY_BASE"
  type  = "SecureString"
  value = "SECRET_KEY_BASE"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_sentry_dsn_apne1" {
  name  = "/conference-app/SENTRY_DSN"
  type  = "SecureString"
  value = "SENTRY_DSN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_social_bluesky_app_password_apne1" {
  name  = "/conference-app/SOCIAL_BLUESKY_APP_PASSWORD"
  type  = "SecureString"
  value = "SOCIAL_BLUESKY_APP_PASSWORD"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_social_bluesky_handle_apne1" {
  name  = "/conference-app/SOCIAL_BLUESKY_HANDLE"
  type  = "SecureString"
  value = "SOCIAL_BLUESKY_HANDLE"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_social_mastodon_access_token_apne1" {
  name  = "/conference-app/SOCIAL_MASTODON_ACCESS_TOKEN"
  type  = "SecureString"
  value = "SOCIAL_MASTODON_ACCESS_TOKEN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_social_mastodon_base_url_apne1" {
  name  = "/conference-app/SOCIAL_MASTODON_BASE_URL"
  type  = "SecureString"
  value = "SOCIAL_MASTODON_BASE_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_social_x_client_id_apne1" {
  name  = "/conference-app/SOCIAL_X_CLIENT_ID"
  type  = "SecureString"
  value = "SOCIAL_X_CLIENT_ID"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_social_x_client_secret_apne1" {
  name  = "/conference-app/SOCIAL_X_CLIENT_SECRET"
  type  = "SecureString"
  value = "SOCIAL_X_CLIENT_SECRET"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_social_x_screen_name_apne1" {
  name  = "/conference-app/SOCIAL_X_SCREEN_NAME"
  type  = "SecureString"
  value = "SOCIAL_X_SCREEN_NAME"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_tito_account_slug_apne1" {
  name  = "/conference-app/TITO_ACCOUNT_SLUG"
  type  = "SecureString"
  value = "TITO_ACCOUNT_SLUG"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_tito_api_token_apne1" {
  name  = "/conference-app/TITO_API_TOKEN"
  type  = "SecureString"
  value = "TITO_API_TOKEN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_tito_webhook_secret_apne1" {
  name  = "/conference-app/TITO_WEBHOOK_SECRET"
  type  = "SecureString"
  value = "TITO_WEBHOOK_SECRET"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_vapid_private_key_apne1" {
  name  = "/conference-app/VAPID_PRIVATE_KEY"
  type  = "SecureString"
  value = "VAPID_PRIVATE_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_vapid_public_key_apne1" {
  name  = "/conference-app/VAPID_PUBLIC_KEY"
  type  = "SecureString"
  value = "VAPID_PUBLIC_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

############################################################

resource "aws_ssm_parameter" "conference_app_staging_active_record_encryption_deterministic_key_apne1" {
  name  = "/conference-app-staging/ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY"
  type  = "SecureString"
  value = "ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_active_record_encryption_key_derivation_salt_apne1" {
  name  = "/conference-app-staging/ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT"
  type  = "SecureString"
  value = "ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_active_record_encryption_primary_key_apne1" {
  name  = "/conference-app-staging/ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY"
  type  = "SecureString"
  value = "ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_cloudflare_access_key_id_apne1" {
  name  = "/conference-app-staging/CLOUDFLARE_ACCESS_KEY_ID"
  type  = "SecureString"
  value = "CLOUDFLARE_ACCESS_KEY_ID"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_cloudflare_account_id_apne1" {
  name  = "/conference-app-staging/CLOUDFLARE_ACCOUNT_ID"
  type  = "SecureString"
  value = "CLOUDFLARE_ACCOUNT_ID"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_cloudflare_api_token_apne1" {
  name  = "/conference-app-staging/CLOUDFLARE_API_TOKEN"
  type  = "SecureString"
  value = "CLOUDFLARE_API_TOKEN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_cloudflare_secret_access_key_apne1" {
  name  = "/conference-app-staging/CLOUDFLARE_SECRET_ACCESS_KEY"
  type  = "SecureString"
  value = "CLOUDFLARE_SECRET_ACCESS_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_cloudflare_r2_bucket_name_apne1" {
  name  = "/conference-app-staging/CLOUDFLARE_R2_BUCKET_NAME"
  type  = "SecureString"
  value = "CLOUDFLARE_R2_BUCKET_NAME"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_cloudflare_r2_endpoint_apne1" {
  name  = "/conference-app-staging/CLOUDFLARE_R2_ENDPOINT"
  type  = "SecureString"
  value = "CLOUDFLARE_R2_ENDPOINT"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_database_url_apne1" {
  name  = "/conference-app-staging/DATABASE_URL"
  type  = "SecureString"
  value = "DATABASE_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_github_app_id_apne1" {
  name  = "/conference-app-staging/GITHUB_APP_ID"
  type  = "SecureString"
  value = "GITHUB_APP_ID"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_github_key_apne1" {
  name  = "/conference-app-staging/GITHUB_KEY"
  type  = "SecureString"
  value = "GITHUB_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_github_private_key_apne1" {
  name  = "/conference-app-staging/GITHUB_PRIVATE_KEY"
  type  = "SecureString"
  value = "GITHUB_PRIVATE_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_github_secret_apne1" {
  name  = "/conference-app-staging/GITHUB_SECRET"
  type  = "SecureString"
  value = "GITHUB_SECRET"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_scout_key_apne1" {
  name  = "/conference-app-staging/SCOUT_KEY"
  type  = "SecureString"
  value = "SCOUT_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_secret_key_base_apne1" {
  name  = "/conference-app-staging/SECRET_KEY_BASE"
  type  = "SecureString"
  value = "SECRET_KEY_BASE"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_sentry_dsn_apne1" {
  name  = "/conference-app-staging/SENTRY_DSN"
  type  = "SecureString"
  value = "SENTRY_DSN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_social_bluesky_app_password_apne1" {
  name  = "/conference-app-staging/SOCIAL_BLUESKY_APP_PASSWORD"
  type  = "SecureString"
  value = "SOCIAL_BLUESKY_APP_PASSWORD"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_social_bluesky_handle_apne1" {
  name  = "/conference-app-staging/SOCIAL_BLUESKY_HANDLE"
  type  = "SecureString"
  value = "SOCIAL_BLUESKY_HANDLE"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_social_mastodon_access_token_apne1" {
  name  = "/conference-app-staging/SOCIAL_MASTODON_ACCESS_TOKEN"
  type  = "SecureString"
  value = "SOCIAL_MASTODON_ACCESS_TOKEN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_social_mastodon_base_url_apne1" {
  name  = "/conference-app-staging/SOCIAL_MASTODON_BASE_URL"
  type  = "SecureString"
  value = "SOCIAL_MASTODON_BASE_URL"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_social_x_client_id_apne1" {
  name  = "/conference-app-staging/SOCIAL_X_CLIENT_ID"
  type  = "SecureString"
  value = "SOCIAL_X_CLIENT_ID"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_social_x_client_secret_apne1" {
  name  = "/conference-app-staging/SOCIAL_X_CLIENT_SECRET"
  type  = "SecureString"
  value = "SOCIAL_X_CLIENT_SECRET"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_social_x_screen_name_apne1" {
  name  = "/conference-app-staging/SOCIAL_X_SCREEN_NAME"
  type  = "SecureString"
  value = "SOCIAL_X_SCREEN_NAME"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_tito_account_slug_apne1" {
  name  = "/conference-app-staging/TITO_ACCOUNT_SLUG"
  type  = "SecureString"
  value = "TITO_ACCOUNT_SLUG"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_tito_api_token_apne1" {
  name  = "/conference-app-staging/TITO_API_TOKEN"
  type  = "SecureString"
  value = "TITO_API_TOKEN"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_tito_webhook_secret_apne1" {
  name  = "/conference-app-staging/TITO_WEBHOOK_SECRET"
  type  = "SecureString"
  value = "TITO_WEBHOOK_SECRET"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_vapid_private_key_apne1" {
  name  = "/conference-app-staging/VAPID_PRIVATE_KEY"
  type  = "SecureString"
  value = "VAPID_PRIVATE_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "conference_app_staging_vapid_public_key_apne1" {
  name  = "/conference-app-staging/VAPID_PUBLIC_KEY"
  type  = "SecureString"
  value = "VAPID_PUBLIC_KEY"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "random_bytes" "conference_app_cloudfront_origin_secret" {
  length = 64
}

resource "aws_ssm_parameter" "conference_app_cloudfront_origin_secret_apne1" {
  name  = "/conference-app/CLOUDFRONT_ORIGIN_SECRET"
  type  = "SecureString"
  value = random_bytes.conference_app_cloudfront_origin_secret.base64
}

resource "random_bytes" "conference_app_staging_cloudfront_origin_secret" {
  length = 64
}

resource "aws_ssm_parameter" "conference_app_staging_cloudfront_origin_secret_apne1" {
  name  = "/conference-app-staging/CLOUDFRONT_ORIGIN_SECRET"
  type  = "SecureString"
  value = random_bytes.conference_app_staging_cloudfront_origin_secret.base64
}
