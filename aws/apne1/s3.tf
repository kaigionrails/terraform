resource "aws_s3_bucket" "kaigionrails_archive" {
  bucket = "kaigionrails-archive"
}

resource "aws_s3_bucket_ownership_controls" "kaigionrails_archive" {
  bucket = aws_s3_bucket.kaigionrails_archive.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
