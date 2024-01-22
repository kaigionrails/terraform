terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.20.0"
    }
  }
}

variable "cloudflare_api_token" {
  description = "TF_VAR_cloudflare_api_token"
  type        = string
}

variable "cloudflare_account_id" {
  description = "TF_VAR_cloudflare_account_id"
  type        = string
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
