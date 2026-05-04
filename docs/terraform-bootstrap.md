# Terraform Bootstrap Checklist

Use this checklist to activate CI/CD for this repository.

## 0) What you repeat vs what you do once

- **Once per AWS account:** GitHub OIDC identity provider (`token.actions.githubusercontent.com`). If you already added it for the FlowBoard SAM repo, **do not create a second provider** — reuse the same account-wide provider.
- **Once per GitHub repo:** GitHub Environments, environment secrets, branch protections, and **new IAM deploy roles** whose trust policy `sub` includes **this** repo name (`flowboard-terraform-platform`).

Copy-paste JSON lives under `docs/iam/` (trust + deploy policy). Replace `857721769900` / `ap-south-1` if your account or region differs.

## 1) Branches

Create long-lived branches:

- `dev`
- `staging`
- `main`

## 2) GitHub Environments

Create:

- `dev`
- `staging`
- `production`

Add to each environment:

- Secret: `AWS_ROLE_TO_ASSUME`
- Variable: `AWS_REGION` (example `ap-south-1`)

Enable required reviewer for `production`.

## 3) AWS IAM OIDC

Ensure identity provider exists in AWS IAM:

- `https://token.actions.githubusercontent.com`
- audience: `sts.amazonaws.com`

If it already exists from another project in the same account, skip creation.

## 4) Deploy roles

Create environment-specific roles and store each ARN in corresponding GitHub environment secret:

- `flowboard-terraform-deploy-dev`
- `flowboard-terraform-deploy-staging`
- `flowboard-terraform-deploy-prod`

Attach trust policies from:

- `docs/iam/github-oidc-trust-dev.json`
- `docs/iam/github-oidc-trust-staging.json`
- `docs/iam/github-oidc-trust-production.json`

Attach permissions policy (baseline for this stack) from:

- `docs/iam/terraform-github-deploy-policy.json`

Trust `sub` values (GitHub Actions jobs use `environment:` keys, so **environment-based** `sub`, not `ref:refs/heads/...`):

- `repo:HassaanAfzal123/flowboard-terraform-platform:environment:dev`
- `repo:HassaanAfzal123/flowboard-terraform-platform:environment:staging`
- `repo:HassaanAfzal123/flowboard-terraform-platform:environment:production`

## 5) First validation run

1. Open PR into `dev` and verify `Terraform CI` passes.
2. Merge into `dev` and verify `Terraform Deploy` -> `Deploy dev`.
3. Promote `dev` -> `staging`.
4. Promote `staging` -> `main` and approve production deployment.
