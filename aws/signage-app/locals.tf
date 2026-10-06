locals {
  signage_app = {
    name_prefix            = "kor-signage-app-prd"
    iam_role_prefix        = "SignageApp"
    app_domain             = "signage.kaigionrails.org"
    cognito_domain         = "kor-signage"
    google_oauth_client_id = "385679957494-a7u8riuuegmibcsdkksq6vnpkc4bi9u9.apps.googleusercontent.com"
    callback_urls          = ["https://signage.kaigionrails.org/oauth2callback"]
    cloudfront_log_prefix  = "cloudfront/signage-app"
  }

  signage_app_dev = {
    name_prefix            = "kor-signage-app-dev"
    iam_role_prefix        = "SignageAppDev"
    app_domain             = "signage-dev.kaigionrails.org"
    cognito_domain         = "kor-signage-dev"
    google_oauth_client_id = "385679957494-vft7s0i8v47r85tmv0poqqjtp9tlc12t.apps.googleusercontent.com"
    callback_urls = [
      "https://signage-dev.kaigionrails.org/oauth2callback",
      "http://localhost:5173/oauth2callback",
    ]
    cloudfront_log_prefix = "cloudfront/signage-app-dev"
  }

  iot_arn_prefix = "arn:aws:iot:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}"
}
