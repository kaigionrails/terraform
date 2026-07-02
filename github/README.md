# GitHub repository management

Manage GitHub repository settings — repository options, merge strategy, branch
protection, vulnerability alerts, and a shared `renovate.json` — as code with the
[`integrations/github`](https://registry.terraform.io/providers/integrations/github/latest)
provider, so you don't have to click through the GitHub UI for every new repository.

## What it manages

- `github_repository` — visibility, merge settings (`delete_branch_on_merge`,
  squash-only merges, auto-merge), issues/wiki/projects toggles, topics.
- `github_branch_protection` — protection on the default branch.
- Vulnerability alerts — via the repository's `vulnerability_alerts` argument.
- `github_repository_file` — drops `files/renovate.json` into each repository.

## Usage

1. Set credentials as environment variables:

   ```sh
   export TF_VAR_github_owner="<your-github-username>"
   export TF_VAR_github_token="<PAT with repo, delete_repo scopes>"
   ```

2. Add repositories to `local.repository_configs` in `repositories.tf`. Any key
   you omit falls back to `local.repository_defaults`:

   ```hcl
   repository_configs = {
     my-new-app = {
       description = "..."
       topics      = ["ruby", "rails"]
     }
     my-public-lib = {
       visibility = "public"
     }
   }
   ```

3. Plan and apply:

   ```sh
   terraform init
   terraform plan
   terraform apply
   ```

## Importing existing repositories

To bring an existing repository under management, add it to
`local.repository_configs` and import it before applying:

```sh
terraform import 'github_repository.this["my-existing-repo"]' my-existing-repo
```

## Notes

- Branch protection on **private** repositories requires a paid plan
  (GitHub Pro / Team / Enterprise Cloud). Public repositories work on Free.
- `github_repository` sets `prevent_destroy = true` as a safety net. To stop
  managing a repository without deleting it on GitHub, run
  `terraform state rm 'github_repository.this["<name>"]'`.
