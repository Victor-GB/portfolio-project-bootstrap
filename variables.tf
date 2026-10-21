variable "repositories" {
  description = "GitHub repositories to manage, keyed by repository name."
  type = map(
    object(
      {
        description         = string
        visibility          = string
        content_ready       = optional(bool, false)
        pip_directory       = optional(string, "/")
        npm_directory       = optional(string)
        pip_enabled         = optional(bool, true)
        terraform_directory = optional(string)
        codeql_enabled      = optional(bool, true)
      }
    )
  )
}