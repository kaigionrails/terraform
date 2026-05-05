resource "aws_s3_bucket" "sponsor_app" {
  bucket = "kor-sponsor-app-production"
}

resource "aws_s3_bucket_ownership_controls" "sponsor_app" {
  bucket = aws_s3_bucket.sponsor_app.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_cors_configuration" "sponsor_app" {
  bucket = aws_s3_bucket.sponsor_app.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["DELETE", "GET", "HEAD", "PUT", "POST"]
    allowed_origins = ["https://sponsorships.kaigionrails.org"]
    expose_headers  = ["ETag", "x-amz-version-id"]
    max_age_seconds = 0
  }
}

resource "aws_s3_bucket_public_access_block" "sponsor_app" {
  bucket = aws_s3_bucket.sponsor_app.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "sponsor_app" {
  bucket = aws_s3_bucket.sponsor_app.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "sponsor_app" {
  bucket = aws_s3_bucket.sponsor_app.id

  transition_default_minimum_object_size = "varies_by_storage_class"

  rule {
    id     = "abort-multipart"
    status = "Enabled"
    filter {}
    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }
  }
}

resource "aws_s3_bucket_accelerate_configuration" "sponsor_app" {
  bucket = aws_s3_bucket.sponsor_app.id
  status = "Enabled"
}

resource "aws_s3_bucket" "sponsor_app_staging" {
  bucket = "kor-sponsor-app-staging"
}

resource "aws_s3_bucket_ownership_controls" "sponsor_app_staging" {
  bucket = aws_s3_bucket.sponsor_app_staging.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_cors_configuration" "sponsor_app_staging" {
  bucket = aws_s3_bucket.sponsor_app_staging.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["DELETE", "GET", "HEAD", "PUT", "POST"]
    allowed_origins = ["https://sponsorships-staging.kaigionrails.org"]
    expose_headers  = ["ETag", "x-amz-version-id"]
    max_age_seconds = 0
  }
}

resource "aws_s3_bucket_public_access_block" "sponsor_app_staging" {
  bucket = aws_s3_bucket.sponsor_app_staging.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "sponsor_app_staging" {
  bucket = aws_s3_bucket.sponsor_app_staging.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "sponsor_app_staging" {
  bucket = aws_s3_bucket.sponsor_app_staging.id

  transition_default_minimum_object_size = "varies_by_storage_class"

  rule {
    id     = "abort-multipart"
    status = "Enabled"
    filter {}
    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }
  }
}

resource "aws_s3_bucket_accelerate_configuration" "sponsor_app_staging" {
  bucket = aws_s3_bucket.sponsor_app_staging.id
  status = "Enabled"
}
