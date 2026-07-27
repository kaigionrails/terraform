data "aws_cloudfront_cache_policy" "Managed-CachingDisabled" {
  name = "Managed-CachingDisabled"
}

data "aws_cloudfront_cache_policy" "Managed-CachingOptimized" {
  name = "Managed-CachingOptimized"
}

data "aws_cloudfront_origin_request_policy" "Managed-AllViewerExceptHostHeader" {
  name = "Managed-AllViewerExceptHostHeader"
}

data "aws_acm_certificate" "conference_app" {
  region      = "us-east-1" # For cloudfront
  domain      = "app.kaigionrails.org"
  statuses    = ["ISSUED"]
  most_recent = true
}

data "aws_acm_certificate" "conference_app_staging" {
  region      = "us-east-1" # For cloudfront
  domain      = "app-staging.kaigionrails.org"
  statuses    = ["ISSUED"]
  most_recent = true
}

resource "aws_cloudfront_distribution" "conference_app" {
  comment = "conference-app production"

  enabled         = true
  is_ipv6_enabled = true
  http_version    = "http2and3"
  price_class     = "PriceClass_All"

  aliases = ["app.kaigionrails.org"]

  viewer_certificate {
    acm_certificate_arn            = data.aws_acm_certificate.conference_app.arn
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }

  origin {
    origin_id   = "origin-app"
    domain_name = "origin-app.kaigionrails.org"

    custom_header {
      name  = "x-forwarded-host"
      value = "app.kaigionrails.org"
    }

    custom_header {
      name  = "x-origin-secret"
      value = random_bytes.conference_app_cloudfront_origin_secret.base64
    }

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_read_timeout      = 30
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "https-only"
      origin_ssl_protocols     = ["TLSv1.2"]
    }
  }

  ordered_cache_behavior {
    target_origin_id         = "origin-app"
    path_pattern             = "/assets/*"
    allowed_methods          = ["GET", "HEAD"]
    cached_methods           = ["GET", "HEAD"]
    compress                 = true
    cache_policy_id          = data.aws_cloudfront_cache_policy.Managed-CachingOptimized.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.Managed-AllViewerExceptHostHeader.id
    viewer_protocol_policy   = "redirect-to-https"
  }

  default_cache_behavior {
    target_origin_id         = "origin-app"
    allowed_methods          = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods           = ["GET", "HEAD"]
    compress                 = true
    cache_policy_id          = data.aws_cloudfront_cache_policy.Managed-CachingDisabled.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.Managed-AllViewerExceptHostHeader.id
    viewer_protocol_policy   = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

resource "aws_cloudfront_distribution" "conference_app_staging" {
  comment = "conference-app staging"

  enabled         = true
  is_ipv6_enabled = true
  http_version    = "http2and3"
  price_class     = "PriceClass_All"

  aliases = ["app-staging.kaigionrails.org"]

  viewer_certificate {
    acm_certificate_arn            = data.aws_acm_certificate.conference_app_staging.arn
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }

  origin {
    origin_id   = "origin-app-staging"
    domain_name = "origin-app-staging.kaigionrails.org"

    custom_header {
      name  = "x-forwarded-host"
      value = "app-staging.kaigionrails.org"
    }

    custom_header {
      name  = "x-origin-secret"
      value = random_bytes.conference_app_staging_cloudfront_origin_secret.base64
    }

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_read_timeout      = 30
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "https-only"
      origin_ssl_protocols     = ["TLSv1.2"]
    }
  }

  ordered_cache_behavior {
    target_origin_id         = "origin-app-staging"
    path_pattern             = "/assets/*"
    allowed_methods          = ["GET", "HEAD"]
    cached_methods           = ["GET", "HEAD"]
    compress                 = true
    cache_policy_id          = data.aws_cloudfront_cache_policy.Managed-CachingOptimized.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.Managed-AllViewerExceptHostHeader.id
    viewer_protocol_policy   = "redirect-to-https"
  }

  default_cache_behavior {
    target_origin_id         = "origin-app-staging"
    allowed_methods          = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods           = ["GET", "HEAD"]
    compress                 = true
    cache_policy_id          = data.aws_cloudfront_cache_policy.Managed-CachingDisabled.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.Managed-AllViewerExceptHostHeader.id
    viewer_protocol_policy   = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}
