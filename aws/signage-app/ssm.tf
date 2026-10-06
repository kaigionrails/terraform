resource "aws_ssm_parameter" "signage_app_dev_google_oauth_client_secret" {
  name  = "/signage-app-dev/GOOGLE_OAUTH_CLIENT_SECRET"
  type  = "SecureString"
  value = "GOOGLE_OAUTH_CLIENT_SECRET"
  lifecycle {
    ignore_changes = [value]
  }
}
