output "signage_app_dev_frontend_config" {
  value     = local.signage_app_dev_frontend_config
  sensitive = true
}

output "signage_app_dev_cloudfront_domain_name" {
  value = aws_cloudfront_distribution.signage_app_dev.domain_name
}
