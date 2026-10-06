resource "aws_dynamodb_table" "signage_app" {
  name         = local.signage_app.name_prefix
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "pk"
  range_key    = "sk"

  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  global_secondary_index {
    name            = "inverted"
    hash_key        = "sk"
    range_key       = "pk"
    projection_type = "ALL"
  }
}

resource "aws_dynamodb_table" "signage_app_dev" {
  name         = local.signage_app_dev.name_prefix
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "pk"
  range_key    = "sk"

  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  global_secondary_index {
    name            = "inverted"
    hash_key        = "sk"
    range_key       = "pk"
    projection_type = "ALL"
  }
}
