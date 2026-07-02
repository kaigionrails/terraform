terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

variable "github_owner" {
  description = "TF_VAR_github_owner (GitHub account that owns the managed repositories)"
  type        = string
}

variable "github_token" {
  description = "TF_VAR_github_token (PAT with repo and delete_repo scopes)"
  type        = string
  sensitive   = true
}

provider "github" {
  owner = var.github_owner
  token = var.github_token
}
