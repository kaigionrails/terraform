resource "aws_acm_certificate" "sponsor_app_staging" {
  region            = "us-east-1" # For cloudfront
  domain_name       = "sponsorships-staging.kaigionrails.org"
  validation_method = "DNS"
}
