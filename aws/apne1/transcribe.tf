# Takes very long time
# resource "aws_transcribe_language_model" "kaigionrails_ja" {
#   model_name      = "kaigionrails-ja"
#   base_model_name = "WideBand"
#   language_code   = "ja-JP"
#   input_data_config {
#     data_access_role_arn = aws_iam_role.kaigionrails_archive_bucket_read.arn
#     s3_uri               = "s3://${aws_s3_bucket.kaigionrails_archive.id}/2024/transcription/ja/"
#   }
# }
