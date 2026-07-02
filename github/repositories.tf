locals {
  # Settings shared by every managed repository. Override per repository in
  # local.repository_configs below.
  repository_defaults = {
    visibility             = "private"
    default_branch         = "main"
    description            = null
    homepage_url           = null
    topics                 = []
    has_issues             = true
    has_projects           = false
    has_wiki               = false
    allow_merge_commit     = false
    allow_squash_merge     = true
    allow_rebase_merge     = false
    allow_auto_merge       = true
    delete_branch_on_merge = true
    vulnerability_alerts   = true
    # Whether to create a renovate.json in the repository.
    manage_renovate = true
    # Whether to enforce branch protection on the default branch.
    protect_default_branch = true
  }

  # Per-repository configuration. Add an entry here to bring a repository under
  # Terraform management. Any key omitted falls back to repository_defaults.
  #
  #   example-repo = {
  #     description = "..."
  #     topics      = ["ruby", "rails"]
  #   }
  repository_configs = {
  }

  # Merge each repository's config over the shared defaults.
  repositories = {
    for name, config in local.repository_configs :
    name => merge(local.repository_defaults, config)
  }
}

resource "github_repository" "this" {
  for_each = local.repositories

  name         = each.key
  description  = each.value.description
  homepage_url = each.value.homepage_url
  visibility   = each.value.visibility
  topics       = each.value.topics

  has_issues   = each.value.has_issues
  has_projects = each.value.has_projects
  has_wiki     = each.value.has_wiki

  allow_merge_commit     = each.value.allow_merge_commit
  allow_squash_merge     = each.value.allow_squash_merge
  allow_rebase_merge     = each.value.allow_rebase_merge
  allow_auto_merge       = each.value.allow_auto_merge
  delete_branch_on_merge = each.value.delete_branch_on_merge

  vulnerability_alerts = each.value.vulnerability_alerts

  # Initialise new repositories so branch protection and managed files have a
  # default branch to attach to. Existing repositories are unaffected.
  auto_init = true

  lifecycle {
    # Avoid destroying a repository if it is removed from configuration by
    # accident. Remove it from state with `terraform state rm` instead.
    prevent_destroy = true
  }
}
