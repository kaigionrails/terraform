resource "github_branch_protection" "default" {
  for_each = {
    for name, config in local.repositories :
    name => config if config.protect_default_branch
  }

  repository_id = github_repository.this[each.key].node_id
  pattern       = each.value.default_branch

  enforce_admins         = false
  require_signed_commits = false
  allows_deletions       = false
  allows_force_pushes    = false

  required_pull_request_reviews {
    required_approving_review_count = 0
    dismiss_stale_reviews           = true
  }
}
