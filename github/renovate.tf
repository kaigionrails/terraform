resource "github_repository_file" "renovate" {
  for_each = {
    for name, config in local.repositories :
    name => config if config.manage_renovate
  }

  repository          = github_repository.this[each.key].name
  branch              = github_repository.this[each.key].default_branch
  file                = "renovate.json"
  content             = file("${path.module}/files/renovate.json")
  commit_message      = "Add Renovate configuration (managed by Terraform)"
  commit_author       = "Terraform"
  commit_email        = "terraform@users.noreply.github.com"
  overwrite_on_create = true
}
