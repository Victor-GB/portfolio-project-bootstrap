output "repository_ssh_urls" {
  description = "SSH clone URLs keyed by repository name."
  value = {
    for name, repo in github_repository.projects :
    name => repo.ssh_clone_url

  }

}