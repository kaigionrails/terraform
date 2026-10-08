resource "aws_cognito_user_pool" "signage_app" {
  name             = local.signage_app.name_prefix
  alias_attributes = ["preferred_username", "email"]
}

resource "aws_cognito_user_pool_domain" "signage_app" {
  user_pool_id = aws_cognito_user_pool.signage_app.id
  domain       = local.signage_app.cognito_domain
}

resource "aws_cognito_identity_provider" "signage_app_google" {
  user_pool_id  = aws_cognito_user_pool.signage_app.id
  provider_name = "externaloidc"
  provider_type = "OIDC"

  provider_details = {
    attributes_request_method     = "GET"
    authorize_scopes              = "email profile openid"
    client_id                     = local.signage_app.google_oauth_client_id
    client_secret                 = aws_ssm_parameter.signage_app_google_oauth_client_secret.value
    oidc_issuer                   = "https://accounts.google.com"
    attributes_url_add_attributes = false
  }

  attribute_mapping = {
    email    = "email"
    name     = "name"
    username = "sub"
  }
}

resource "aws_cognito_user_pool_client" "signage_app" {
  user_pool_id = aws_cognito_user_pool.signage_app.id
  name         = "${local.signage_app.name_prefix}-cognito-identity"

  callback_urls   = local.signage_app.callback_urls
  generate_secret = true

  access_token_validity = 18
  id_token_validity     = 18

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]
  supported_identity_providers         = [aws_cognito_identity_provider.signage_app_google.provider_name]

  write_attributes = []
}

resource "aws_cognito_identity_pool" "signage_app" {
  identity_pool_name               = local.signage_app.name_prefix
  allow_unauthenticated_identities = true
  allow_classic_flow               = true

  cognito_identity_providers {
    client_id               = aws_cognito_user_pool_client.signage_app.id
    provider_name           = aws_cognito_user_pool.signage_app.endpoint
    server_side_token_check = false
  }
}

resource "aws_cognito_user_pool" "signage_app_dev" {
  name             = local.signage_app_dev.name_prefix
  alias_attributes = ["preferred_username", "email"]
}

resource "aws_cognito_user_pool_domain" "signage_app_dev" {
  user_pool_id = aws_cognito_user_pool.signage_app_dev.id
  domain       = local.signage_app_dev.cognito_domain
}

resource "aws_cognito_identity_provider" "signage_app_dev_google" {
  user_pool_id  = aws_cognito_user_pool.signage_app_dev.id
  provider_name = "externaloidc"
  provider_type = "OIDC"

  provider_details = {
    attributes_request_method     = "GET"
    authorize_scopes              = "email profile openid"
    client_id                     = local.signage_app_dev.google_oauth_client_id
    client_secret                 = aws_ssm_parameter.signage_app_dev_google_oauth_client_secret.value
    oidc_issuer                   = "https://accounts.google.com"
    attributes_url_add_attributes = false
  }

  attribute_mapping = {
    email    = "email"
    name     = "name"
    username = "sub"
  }
}

resource "aws_cognito_user_pool_client" "signage_app_dev" {
  user_pool_id = aws_cognito_user_pool.signage_app_dev.id
  name         = "${local.signage_app_dev.name_prefix}-cognito-identity"

  callback_urls   = local.signage_app_dev.callback_urls
  generate_secret = true

  access_token_validity = 18
  id_token_validity     = 18

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]
  supported_identity_providers         = [aws_cognito_identity_provider.signage_app_dev_google.provider_name]

  write_attributes = []
}

resource "aws_cognito_identity_pool" "signage_app_dev" {
  identity_pool_name               = local.signage_app_dev.name_prefix
  allow_unauthenticated_identities = true
  allow_classic_flow               = true

  cognito_identity_providers {
    client_id               = aws_cognito_user_pool_client.signage_app_dev.id
    provider_name           = aws_cognito_user_pool.signage_app_dev.endpoint
    server_side_token_check = false
  }
}
