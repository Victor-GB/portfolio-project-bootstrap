data "github_user" "current" {
  username = ""
}

output "current_github_login" {
  value = data.github_user.current.login
}