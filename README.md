# Portfolio Project Bootstrap

Terraform automation for creating GitHub repositories and managing a
consistent repository security baseline.

Work in progress: repository creation, HCP state storage and Dependabot
automation have been verified on Fyyur. Terraform explicitly manages
Fyyur's existing secret scanning and push protection settings, and enables
CodeQL default setup through GitHub's API. CodeQL analysis and a subsequent
no-change plan have been verified. Existing-repository adoption and broader
repeatability checks remain outstanding.

Local Python development setup belongs to a separate automation utility.

## Ownership and verification

Terraform will manage repository identity, description, visibility,
Dependabot alerts and security updates, secret scanning and push protection.

Terraform will own `.github/dependabot.yml` after existing content has
been inspected and reconciled. Subsequent deliberate changes to this
file must also be reflected in the Terraform configuration.

Terraform manages CodeQL default setup through the Mastercard REST API
provider, using GitHub's default query suite and standard runners.
GitHub selects the analysis languages. Applying removal of the CodeQL
resource disables default setup.

Application code, tests, dependencies and development workflows remain
owned by the consuming project. Local checkout configuration, Git remotes,
virtual environments and hooks belong to a separate Python utility.

Existing resources will be inspected and imported before applying changes.
Adoption must include review of other repository properties controlled
by the same Terraform resource.

Completion requires verified GitHub controls, a subsequent Terraform plan
with no changes, and preservation of unrelated settings and application
content.

## GitHub API authentication

Authenticate with GitHub CLI before running Terraform. The GitHub provider
can reuse that login. The REST API provider requires its token in the
current terminal session:

```bash
REST_API_BEARER="$(gh auth token --hostname github.com)" &&
export REST_API_BEARER
```

Run this directly, without logging token retrieval. The token is supplied
through the environment rather than committed configuration.

## Terraform state

State storage: HCP Terraform.
Execution: local, on the Ubuntu development machine.

- Organisation: `victor-gb-portfolio`
- Workspace: `portfolio-project-bootstrap`
- Workspace execution mode: Local (custom)

Terraform CLI authentication is stored outside this repository.
Credentials, state files and local repository inputs must not be committed.

## Reconnecting from a replacement machine

Restore the configuration and the intended local `terraform.tfvars`.
Install the pinned Terraform version and authenticate with GitHub.

Load `REST_API_BEARER` in that terminal using the authentication instructions above.

Run `terraform login`, then `terraform init` to reconnect to the existing
HCP workspace. Run `terraform plan` and review it before applying changes.

Reconnecting requires access to the HCP account and workspace.
It does not require recreating repositories already recorded in that state.
