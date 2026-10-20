# Portfolio Project Bootstrap

Terraform automation for creating GitHub repositories and managing a
consistent repository security baseline.

Work in progress: repository creation, HCP state storage and Dependabot
automation have been verified on Fyyur. Additional automated security
controls and existing-repository adoption remain to be implemented.

Local Python development setup belongs to a separate automation utility.

## Ownership and verification

Terraform will manage repository identity, description, visibility,
Dependabot alerts and security updates, secret scanning and push protection.

Terraform will own `.github/dependabot.yml` after existing content has
been inspected and reconciled. Subsequent deliberate changes to this
file must also be reflected in the Terraform configuration.

CodeQL default setup is within scope. Its integration method remains
to be selected and verified.

Application code, tests, dependencies and development workflows remain
owned by the consuming project. Local checkout configuration, Git remotes,
virtual environments and hooks belong to a separate Python utility.

Existing resources will be inspected and imported before applying changes.
Adoption must include review of other repository properties controlled
by the same Terraform resource.

Completion requires verified GitHub controls, a subsequent Terraform plan
with no changes, and preservation of unrelated settings and application
content.

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

Run `terraform login`, then `terraform init` to reconnect to the existing
HCP workspace. Run `terraform plan` and review it before applying changes.

Reconnecting requires access to the HCP account and workspace.
It does not require recreating repositories already recorded in that state.
