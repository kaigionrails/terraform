data "aws_acm_certificate" "cfp_app" {
  region      = "us-east-1"
  domain      = "cfp.kaigionrails.org"
  statuses    = ["ISSUED"]
  most_recent = true
}

data "aws_cloudfront_cache_policy" "Managed-CachingDisabled" {
  name = "Managed-CachingDisabled"
}

data "aws_cloudfront_cache_policy" "Managed-CachingOptimized" {
  name = "Managed-CachingOptimized"
}

data "aws_cloudfront_origin_request_policy" "Managed-AllViewerExceptHostHeader" {
  name = "Managed-AllViewerExceptHostHeader"
}

resource "aws_cloudfront_distribution" "cfp_app" {
  comment = "cfp-app production"

  enabled         = true
  is_ipv6_enabled = true
  http_version    = "http2and3"
  price_class     = "PriceClass_All"

  aliases = ["cfp.kaigionrails.org"]

  viewer_certificate {
    acm_certificate_arn            = data.aws_acm_certificate.cfp_app.arn
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }

  origin {
    origin_id   = "origin-cfp"
    domain_name = "origin-cfp.kaigionrails.org"

    custom_header {
      name  = "x-forwarded-host"
      value = "cfp.kaigionrails.org"
    }

    custom_header {
      name  = "x-origin-secret"
      value = random_bytes.cfp_app_cloudfront_origin_secret.base64
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
    target_origin_id         = "origin-cfp"
    path_pattern             = "/assets/*"
    allowed_methods          = ["GET", "HEAD"]
    cached_methods           = ["GET", "HEAD"]
    compress                 = true
    cache_policy_id          = data.aws_cloudfront_cache_policy.Managed-CachingOptimized.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.Managed-AllViewerExceptHostHeader.id
    viewer_protocol_policy   = "redirect-to-https"
  }

  default_cache_behavior {
    target_origin_id         = "origin-cfp"
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
