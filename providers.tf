provider "github" {
  owner = "Victor-GB"
}

provider "restapi" {
  uri                  = "https://api.github.com"
  write_returns_object = false

  headers = {
    Accept               = "application/vnd.github+json"
    X-GitHub-Api-version = "2022-11-28"
  }

}