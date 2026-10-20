variable "repositories" {
  description = "GitHub repositories to manage, keyed by repository name."
  type = map(
    object(
      {
        description = string
        visibility  = string
      }
    )
  )
}