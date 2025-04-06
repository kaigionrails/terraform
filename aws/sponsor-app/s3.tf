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
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["https://sponsorships-staging.kaigionrails.org"]
    max_age_seconds = 3000
  }
}
