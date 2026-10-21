resource "github_repository_file" "dependabot" {
  for_each = local.content_ready_repositories

  repository = each.value.name
  file       = ".github/dependabot.yml"
  content = templatefile("${path.module}/templates/dependabot.yml.tftpl", {
    pip_directory       = var.repositories[each.key].pip_directory
    npm_directory       = var.repositories[each.key].npm_directory
    pip_enabled         = var.repositories[each.key].pip_enabled
    terraform_directory = var.repositories[each.key].terraform_directory
  })


  commit_message      = "Configure Dependabot updates"
  overwrite_on_create = false
}