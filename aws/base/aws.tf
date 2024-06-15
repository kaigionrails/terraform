terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  kaigionrails_aws_account_id = "861452569180"
}

provider "aws" {
  region              = "ap-northeast-1"
  allowed_account_ids = [local.kaigionrails_aws_account_id]

  default_tags {
    tags = {
      "Project" = "kaigionrails"
    }
  }
}

data "aws_caller_identity" "curent" {}
