terraform {
  backend "s3" {
    bucket              = "kaigionrails-terraform"
    region              = "ap-northeast-1"
    key                 = "aws_usw2.tfstate"
    allowed_account_ids = ["861452569180"]
    dynamodb_table      = "kaigionrails-terraform"
  }
}
