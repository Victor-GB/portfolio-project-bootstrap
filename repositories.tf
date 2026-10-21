resource "github_repository" "projects" {
  for_each = var.repositories

  name        = each.key
  description = each.value.description
  visibility  = each.value.visibility

  auto_init    = false
  has_issues   = true
  has_projects = false
  has_wiki     = false

  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }

    secret_scanning_push_protection {
      status = "enabled"
    }
  }
}

