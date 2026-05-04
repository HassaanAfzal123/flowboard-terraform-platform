# FlowBoard Terraform Platform

Production-style Terraform platform for the FlowBoard serverless backend on AWS.

## What this project provisions

- API Gateway HTTP API
- Lambda function
- IAM role and least-privilege policies for runtime access to SSM/KMS
- CloudWatch log group and error alarm
- Environment-specific stacks (`dev`, `staging`, `prod`)

## Repository layout

```text
flowboard-terraform-platform/
├── infra/terraform/
│   ├── backend.tf
│   ├── versions.tf
│   ├── variables.tf
│   ├── locals.tf
│   ├── main.tf
│   └── outputs.tf
├── lambda/
│   └── src/
│       └── handler.js
├── environments/
│   ├── dev.tfvars
│   ├── staging.tfvars
│   └── prod.tfvars
└── .github/workflows/
    ├── terraform-ci.yml
    └── terraform-deploy.yml
```

## Branch to environment mapping

- `dev` -> Terraform apply with `environments/dev.tfvars`
- `staging` -> Terraform apply with `environments/staging.tfvars`
- `main` -> Terraform apply with `environments/prod.tfvars` (production approval gate)

## Local usage

```bash
cd infra/terraform
terraform init
terraform fmt -recursive
terraform validate
terraform plan -var-file="../../environments/dev.tfvars"
```

## Remote state (recommended)

This repository is ready for S3 backend configuration in `infra/terraform/backend.tf`.
Pass backend values in CI/CD (`bucket`, `key`, `region`, `dynamodb_table`) during `terraform init`.

## CI/CD

- PR pipeline runs `terraform fmt -check` and `terraform validate`
- Deploy pipeline runs plan and apply via GitHub Actions + AWS OIDC
- Environment secrets/variables:
  - `AWS_ROLE_TO_ASSUME`
  - `AWS_REGION`
