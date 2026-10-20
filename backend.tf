terraform {
  cloud {
    organization = "victor-gb-portfolio"

    workspaces {
      name = "portfolio-project-bootstrap"
    }
  }
}