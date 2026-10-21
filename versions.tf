terraform {
  required_version = "= 1.16.6"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "= 6.13.0"
    }
    restapi = {
      source  = "Mastercard/restapi"
      version = "=3.0.0"
    }
  }
}