data "aws_iam_policy_document" "kaigionrails_archive_bucket_read_trust" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["transcribe.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "kaigionrails_archive_bucket_read" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
    resources = [
      "${aws_s3_bucket.kaigionrails_archive.arn}",
      "${aws_s3_bucket.kaigionrails_archive.arn}/*",
    ]
  }
}

resource "aws_iam_role" "kaigionrails_archive_bucket_read" {
  name               = "KaigionRailsArchiveBucketRead"
  assume_role_policy = data.aws_iam_policy_document.kaigionrails_archive_bucket_read_trust.json
}

resource "aws_iam_role_policy" "kaigionrails_archive_bucket_read" {
  role   = aws_iam_role.kaigionrails_archive_bucket_read.id
  policy = data.aws_iam_policy_document.kaigionrails_archive_bucket_read.json
}
