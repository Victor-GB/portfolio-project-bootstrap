locals {
  content_ready_repositories = {
    for name, repo in github_repository.projects :
    name => repo
    if var.repositories[name].content_ready
  }
}