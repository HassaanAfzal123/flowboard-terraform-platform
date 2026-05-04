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
terraform init -input=false
terraform fmt -recursive
terraform validate
terraform plan -var-file="../../environments/dev.tfvars"
```

`terraform plan` and `apply` need valid AWS credentials (for example `aws configure` or environment variables).

Commit `infra/terraform/.terraform.lock.hcl` so CI and teammates use the same provider versions.

## State storage (important)

Right now this root module uses **local state** (`terraform.tfstate` next to the config). That is fine for learning and local runs.

For team CI/CD and production, you should move to a **remote S3 backend** (plus DynamoDB for locking) so state is shared and applies are safe. Add a `terraform { backend "s3" { ... } }` block and run `terraform init -backend-config=...` when you are ready; document the bucket, key per environment, and lock table in `docs/terraform-bootstrap.md`.

## CI/CD

- PR pipeline runs `terraform fmt -check` and `terraform validate`
- Deploy pipeline runs plan and apply via GitHub Actions + AWS OIDC
- Environment secrets/variables:
  - `AWS_ROLE_TO_ASSUME`
  - `AWS_REGION`
