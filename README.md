# Portfolio Project Bootstrap

Terraform automation for creating GitHub repositories and managing a
consistent repository security baseline.

Repository creation has been verified on Fyyur and Trivia API, and the
existing asteroid-approach-explorer repository (Neo) has been adopted.

All three repositories use Terraform-managed Dependabot alerts and security
updates, weekly dependency updates, security-update grouping rules, secret
scanning, push protection and CodeQL default setup. Issues are enabled;
Projects and Wiki are disabled.

This bootstrap repository is also managed by the configuration, with weekly
Terraform dependency updates and the shared repository security settings.
CodeQL is excluded here because its current source languages are HCL and Shell.

The complete two-stage creation workflow has been verified on Trivia API.
Drift detection and reconciliation have also been demonstrated. A final
Terraform plan reported no changes across all four repositories.
See [VERIFICATION.md](VERIFICATION.md) for the recorded evidence.

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

`codeql_enabled` defaults to `true`. Set it to `false` for repositories
where CodeQL setup is not applicable. Changing an already managed
repository to `false` proposes removing its CodeQL resource and disabling
default setup.

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

The staged workflow was verified on Trivia API while preserving its supplied
scaffold history, original remote and application files. The local checkout
was then synchronised with the Terraform-created Dependabot commit.

Existing resources will be inspected and imported before applying changes.
Adoption must include review of other repository properties controlled
by the same Terraform resource.

Completion requires verified GitHub controls, a subsequent Terraform plan
with no changes, and preservation of unrelated settings and application
content.

## Dependency update directories

Each repository accepts these optional inputs:

| Input | Default | Purpose |
| --- | --- | --- |
| `pip_enabled` | `true` | Include Python dependency updates |
| `pip_directory` | `"/"` | Directory containing Python dependency files |
| `npm_directory` | `null` | Directory containing npm dependency files; omitted from Dependabot when unset |
| `terraform_directory` | `null` | Directory containing Terraform configuration; omitted from Dependabot when unset |

Directory paths are relative to the repository root and start with `/`.
GitHub Actions updates always use `/`.

For example, Trivia API uses:

```hcl
pip_directory = "/backend"
npm_directory = "/frontend"
```

Terraform renders `templates/dependabot.yml.tftpl` and publishes the result
as `.github/dependabot.yml` in each ready repository.

## Continuous integration

The [Terraform checks workflow](.github/workflows/terraform-checks.yml)
runs on pull requests and pushes to `main`. It checks formatting,
installs the locked providers without initialising the HCP backend,
and validates the Terraform configuration.

CI uses Terraform 1.16.6 and read-only repository permissions. It requires
no personal GitHub or HCP credentials and does not run plans or applies.
Reviewed plans and applies remain local operations.

The committed provider lock file includes checksums for both the Ubuntu
ARM64 development VM and the Linux AMD64 CI runner. When deliberately
updating provider versions, refresh both platforms:

```bash
terraform providers lock -platform=linux_arm64 -platform=linux_amd64
```

References: [Terraform validation](https://developer.hashicorp.com/terraform/cli/commands/validate),
[provider locking across platforms](https://developer.hashicorp.com/terraform/cli/commands/providers/lock#specifying-target-platforms),
and [setup-terraform](https://github.com/hashicorp/setup-terraform).

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
