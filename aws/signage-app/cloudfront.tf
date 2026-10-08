data "aws_cloudfront_origin_request_policy" "Managed-CORS-S3Origin" {
  name = "Managed-CORS-S3Origin"
}
data "aws_cloudfront_cache_policy" "Managed-CachingDisabled" {
  name = "Managed-CachingDisabled"
}
data "aws_cloudfront_cache_policy" "Managed-CachingOptimized" {
  name = "Managed-CachingOptimized"
}

data "aws_s3_bucket" "kaigionrails_logs" {
  bucket = "kaigionrails-logs"
}

data "aws_acm_certificate" "signage_app" {
  region      = "us-east-1" # For cloudfront
  domain      = local.signage_app.app_domain
  statuses    = ["ISSUED"]
  most_recent = true
}

resource "aws_cloudfront_distribution" "signage_app" {
  enabled         = true
  is_ipv6_enabled = true
  comment         = "signage-app prd"
  aliases         = [local.signage_app.app_domain]

  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.signage_app.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }

  origin {
    origin_id   = "s3public-ui"
    domain_name = aws_s3_bucket.signage_app.bucket_regional_domain_name
    origin_path = "/ui"
  }

  origin {
    origin_id   = "s3public-dynamic"
    domain_name = aws_s3_bucket.signage_app.bucket_regional_domain_name
    origin_path = "/dynamic"
  }

  ordered_cache_behavior {
    path_pattern = "/metrics"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    target_origin_id         = "s3public-dynamic"
    cache_policy_id          = data.aws_cloudfront_cache_policy.Managed-CachingDisabled.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.Managed-CORS-S3Origin.id

    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  ordered_cache_behavior {
    path_pattern = "/config.json"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    target_origin_id         = "s3public-dynamic"
    cache_policy_id          = data.aws_cloudfront_cache_policy.Managed-CachingDisabled.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.Managed-CORS-S3Origin.id

    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  ordered_cache_behavior {
    path_pattern = "/data/*"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    target_origin_id         = "s3public-dynamic"
    cache_policy_id          = data.aws_cloudfront_cache_policy.Managed-CachingOptimized.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.Managed-CORS-S3Origin.id

    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    target_origin_id         = "s3public-ui"
    cache_policy_id          = data.aws_cloudfront_cache_policy.Managed-CachingDisabled.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.Managed-CORS-S3Origin.id

    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name      = local.signage_app.name_prefix
    Component = "cloudfront"
  }
}

resource "aws_cloudwatch_log_delivery_source" "signage_app_cloudfront" {
  region       = "us-east-1" # For cloudfront
  name         = "${local.signage_app.name_prefix}-cloudfront"
  log_type     = "ACCESS_LOGS"
  resource_arn = aws_cloudfront_distribution.signage_app.arn
}

resource "aws_cloudwatch_log_delivery_destination" "signage_app_cloudfront" {
  region        = "us-east-1" # For cloudfront
  name          = "${local.signage_app.name_prefix}-cloudfront"
  output_format = "json"

  delivery_destination_configuration {
    destination_resource_arn = "${data.aws_s3_bucket.kaigionrails_logs.arn}/${local.signage_app.cloudfront_log_prefix}"
  }
}

resource "aws_cloudwatch_log_delivery" "signage_app_cloudfront" {
  region                   = "us-east-1" # For cloudfront
  delivery_source_name     = aws_cloudwatch_log_delivery_source.signage_app_cloudfront.name
  delivery_destination_arn = aws_cloudwatch_log_delivery_destination.signage_app_cloudfront.arn
}

data "aws_acm_certificate" "signage_app_dev" {
  region      = "us-east-1" # For cloudfront
  domain      = local.signage_app_dev.app_domain
  statuses    = ["ISSUED"]
  most_recent = true
}

resource "aws_cloudfront_distribution" "signage_app_dev" {
  enabled         = true
  is_ipv6_enabled = true
  comment         = "signage-app dev"
  aliases         = [local.signage_app_dev.app_domain]

  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.signage_app_dev.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }

  origin {
    origin_id   = "s3public-ui"
    domain_name = aws_s3_bucket.signage_app_dev.bucket_regional_domain_name
    origin_path = "/ui"
  }

  origin {
    origin_id   = "s3public-dynamic"
    domain_name = aws_s3_bucket.signage_app_dev.bucket_regional_domain_name
    origin_path = "/dynamic"
  }

  ordered_cache_behavior {
    path_pattern = "/metrics"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    target_origin_id         = "s3public-dynamic"
    cache_policy_id          = data.aws_cloudfront_cache_policy.Managed-CachingDisabled.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.Managed-CORS-S3Origin.id

    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  ordered_cache_behavior {
    path_pattern = "/config.json"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    target_origin_id         = "s3public-dynamic"
    cache_policy_id          = data.aws_cloudfront_cache_policy.Managed-CachingDisabled.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.Managed-CORS-S3Origin.id

    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  ordered_cache_behavior {
    path_pattern = "/data/*"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    target_origin_id         = "s3public-dynamic"
    cache_policy_id          = data.aws_cloudfront_cache_policy.Managed-CachingOptimized.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.Managed-CORS-S3Origin.id

    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    target_origin_id         = "s3public-ui"
    cache_policy_id          = data.aws_cloudfront_cache_policy.Managed-CachingDisabled.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.Managed-CORS-S3Origin.id

    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name      = local.signage_app_dev.name_prefix
    Component = "cloudfront"
  }
}

resource "aws_cloudwatch_log_delivery_source" "signage_app_dev_cloudfront" {
  region       = "us-east-1" # For cloudfront
  name         = "${local.signage_app_dev.name_prefix}-cloudfront"
  log_type     = "ACCESS_LOGS"
  resource_arn = aws_cloudfront_distribution.signage_app_dev.arn
}

resource "aws_cloudwatch_log_delivery_destination" "signage_app_dev_cloudfront" {
  region        = "us-east-1" # For cloudfront
  name          = "${local.signage_app_dev.name_prefix}-cloudfront"
  output_format = "json"

  delivery_destination_configuration {
    destination_resource_arn = "${data.aws_s3_bucket.kaigionrails_logs.arn}/${local.signage_app_dev.cloudfront_log_prefix}"
  }
}

resource "aws_cloudwatch_log_delivery" "signage_app_dev_cloudfront" {
  region                   = "us-east-1" # For cloudfront
  delivery_source_name     = aws_cloudwatch_log_delivery_source.signage_app_dev_cloudfront.name
  delivery_destination_arn = aws_cloudwatch_log_delivery_destination.signage_app_dev_cloudfront.arn
}
