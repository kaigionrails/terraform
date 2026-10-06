resource "aws_s3_bucket" "kaigionrails_archive" {
  bucket = "kaigionrails-archive"
}

resource "aws_s3_bucket_ownership_controls" "kaigionrails_archive" {
  bucket = aws_s3_bucket.kaigionrails_archive.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket" "kaigionrails_logs" {
  bucket = "kaigionrails-logs"
}

resource "aws_s3_bucket_ownership_controls" "kaigionrails_logs" {
  bucket = aws_s3_bucket.kaigionrails_logs.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

data "aws_iam_policy_document" "kaigionrails_logs_logging_policy" {
  statement {
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.kaigionrails_logs.arn}/*"]
    principals {
      type        = "Service"
      identifiers = ["logdelivery.elasticloadbalancing.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:elasticloadbalancing:*:*:loadbalancer/*"]
    }
  }

  statement {
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.kaigionrails_logs.arn}/cloudfront/*"]
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:delivery-source:*"]
    }
  }
}

resource "aws_s3_bucket_policy" "kaigionrails_logs_logging_policy" {
  bucket = aws_s3_bucket.kaigionrails_logs.id
  policy = data.aws_iam_policy_document.kaigionrails_logs_logging_policy.json
}
