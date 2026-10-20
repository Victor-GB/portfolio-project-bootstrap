resource "github_repository_file" "dependabot" {
  for_each = github_repository.projects

  repository          = each.value.name
  file                = ".github/dependabot.yml"
  content             = file("${path.module}/templates/dependabot.yml")
  commit_message      = "Configure Dependabot updates"
  overwrite_on_create = false
}