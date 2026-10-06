resource "aws_s3_bucket" "signage_app_dev" {
  bucket = local.signage_app_dev.name_prefix
}

resource "aws_s3_bucket_public_access_block" "signage_app_dev" {
  bucket = aws_s3_bucket.signage_app_dev.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

data "aws_iam_policy_document" "signage_app_dev_bucket" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.signage_app_dev.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "signage_app_dev" {
  bucket = aws_s3_bucket.signage_app_dev.id
  policy = data.aws_iam_policy_document.signage_app_dev_bucket.json

  depends_on = [aws_s3_bucket_public_access_block.signage_app_dev]
}

locals {
  signage_app_dev_frontend_config = {
    aws_region = data.aws_region.current.region

    iot_endpoint     = data.aws_iot_endpoint.current.endpoint_address
    iot_topic_prefix = local.signage_app_dev.name_prefix

    dynamodb_table_name = aws_dynamodb_table.signage_app_dev.name

    user_pool_issuer        = aws_cognito_user_pool.signage_app_dev.endpoint
    user_pool_authorize_url = "https://${local.signage_app_dev.cognito_domain}.auth.${data.aws_region.current.region}.amazoncognito.com/oauth2/authorize"
    user_pool_token_url     = "https://${local.signage_app_dev.cognito_domain}.auth.${data.aws_region.current.region}.amazoncognito.com/oauth2/token"
    user_pool_client_id     = aws_cognito_user_pool_client.signage_app_dev.id
    user_pool_client_secret = aws_cognito_user_pool_client.signage_app_dev.client_secret

    identity_pool_id = aws_cognito_identity_pool.signage_app_dev.id

    iam_role_arn_unauthenticated_stage1 = aws_iam_role.signage_app_dev_cognito_guest.arn
    iam_role_arn_unauthenticated_stage2 = aws_iam_role.signage_app_dev_browser_guest.arn
    iam_role_arn_authenticated_stage1   = aws_iam_role.signage_app_dev_cognito_user.arn
    iam_role_arn_authenticated_stage2   = aws_iam_role.signage_app_dev_browser_user.arn

    tenant = "default"
  }
}

resource "aws_s3_object" "signage_app_dev_config" {
  bucket        = aws_s3_bucket.signage_app_dev.bucket
  key           = "dynamic/config.json"
  content_type  = "application/json; charset=utf-8"
  cache_control = "max-age=0, must-revalidate"
  content       = "${jsonencode(local.signage_app_dev_frontend_config)}\n"
}
