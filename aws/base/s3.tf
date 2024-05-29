resource "aws_s3_bucket" "terraform" {
  bucket = "kaigionrails-terraform"
}

resource "aws_s3_bucket_versioning" "s3_tfstate_versioning" {
  bucket = aws_s3_bucket.terraform.bucket

  versioning_configuration {
    status = "Enabled"
  }
}
