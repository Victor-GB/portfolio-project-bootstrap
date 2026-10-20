resource "github_repository_vulnerability_alerts" "projects" {
  for_each   = github_repository.projects
  repository = each.value.name
  enabled    = true

}

resource "github_repository_dependabot_security_updates" "projects" {
  for_each   = github_repository_vulnerability_alerts.projects
  repository = each.value.repository
  enabled    = true

}