# Terraform Bootstrap Checklist

Use this checklist to activate CI/CD for this repository.

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

## 4) Deploy roles

Create environment-specific roles and store each ARN in corresponding GitHub environment secret:

- `flowboard-terraform-deploy-dev`
- `flowboard-terraform-deploy-staging`
- `flowboard-terraform-deploy-prod`

Trust policy should allow:

- `repo:HassaanAfzal123/flowboard-terraform-platform:environment:dev`
- `repo:HassaanAfzal123/flowboard-terraform-platform:environment:staging`
- `repo:HassaanAfzal123/flowboard-terraform-platform:environment:production`

## 5) First validation run

1. Open PR into `dev` and verify `Terraform CI` passes.
2. Merge into `dev` and verify `Terraform Deploy` -> `Deploy dev`.
3. Promote `dev` -> `staging`.
4. Promote `staging` -> `main` and approve production deployment.
