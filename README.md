# Portfolio Project Bootstrap

Terraform automation for creating GitHub repositories and managing a
consistent repository security baseline.

Work in progress: repository creation has been verified on Fyyur, and
the existing asteroid-approach-explorer repository (Neo) has been adopted.

Both repositories now use Terraform-managed Dependabot alerts, security
updates, weekly Python and GitHub Actions updates, security-update grouping
rules, secret scanning, push protection and CodeQL default setup. Issues
are enabled; Projects and Wiki are disabled.

Neo's quality checks and CodeQL passed after adoption. A subsequent
Terraform plan reported no changes across both repositories. Broader
repeatability checks and final portfolio documentation remain outstanding.

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
owned by the consuming project. Local Git connection, initial publication
and checkout synchronisation are manual. Python environments and
development tooling remain outside this Terraform project's scope.

For a new repository, `content_ready` defaults to `false`. The first
reviewed apply creates the repository and its repository-level settings,
while deferring the Dependabot file and CodeQL setup. After manually
publishing the scaffold as `main`, set `content_ready = true`, review and
apply a fresh plan, then synchronise the local checkout.

Existing populated repositories explicitly use `content_ready = true`.
Keep this value after setup: changing it to `false` proposes removing the
Dependabot file and disabling CodeQL.

Compatibility with Fyyur and Neo has been verified through a no-change
plan. The complete staged creation workflow awaits verification on a new
project.

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
