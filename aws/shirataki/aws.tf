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

provider "aws" {
  alias               = "usw2"
  region              = "us-west-2"
  allowed_account_ids = [local.kaigionrails_aws_account_id]

  default_tags {
    tags = {
      "Project" = "kaigionrails"
    }
  }
}

data "aws_caller_identity" "curent" {}

data "aws_db_subnet_group" "kaigionrails_apne1_private" {
  name = "kaigionrails-apne1-private"
}

data "aws_vpc" "kaigionrails_apne1" {
  id = "vpc-046d56710c1fe9fdb"
}

data "aws_subnet" "kaigionrails_apne1_c_public" {
  filter {
    name   = "tag:Name"
    values = ["kor-apne1-c-public"]
  }
}

data "aws_subnet" "kaigionrails_apne1_d_public" {
  filter {
    name   = "tag:Name"
    values = ["kor-apne1-d-public"]
  }
}

data "aws_subnet" "kaigionrails_apne1_c_private" {
  filter {
    name   = "tag:Name"
    values = ["kor-apne1-c-private"]
  }
}

data "aws_subnet" "kaigionrails_apne1_d_private" {
  filter {
    name   = "tag:Name"
    values = ["kor-apne1-d-private"]
  }
}

data "aws_s3_bucket" "kaigionrails_logs" {
  bucket = "kaigionrails-logs"
}
