# FlowBoard Terraform Portfolio

Focused Terraform portfolio implementation for serverless AWS infrastructure.

This repository demonstrates Terraform proficiency with minimal operational overhead:

- reusable Terraform module design
- environment-driven root configuration
- CI quality gates (`fmt`, `validate`, `plan`)
- infrastructure parity with a Lambda + HTTP API architecture

## Why this scope

This project intentionally avoids full deployment automation/OIDC wiring at this stage to reduce setup overhead while still proving core Terraform skills. It is designed for interview discussion and fast iteration.

## Repository layout

```text
flowboard-terraform-platform/
|-- modules/
|   `-- lambda-http-api/
|       |-- main.tf
|       |-- variables.tf
|       |-- locals.tf
|       `-- outputs.tf
|-- infra/terraform/
|   |-- versions.tf
|   |-- variables.tf
|   |-- main.tf
|   `-- outputs.tf
|-- lambda/
|   `-- src/
|       `-- handler.js
`-- .github/workflows/
    `-- terraform-ci.yml
```

## What the module provisions

- Lambda function
- API Gateway HTTP API (`ANY /` and `ANY /{proxy+}`)
- IAM role + runtime SSM/KMS permissions
- CloudWatch log group and error alarm
- Lambda invocation permission for API Gateway

## Local usage

```bash
cd infra/terraform
terraform init -input=false
terraform fmt -recursive
terraform validate
terraform plan -no-color
```

Use your AWS credentials locally (`aws configure`) if you want a real plan against your account.

## CI behavior

On pull requests, GitHub Actions runs:

- `terraform fmt -check -recursive`
- `terraform init -input=false`
- `terraform validate`
- `terraform plan -refresh=false`

This gives fast IaC quality feedback without requiring full cloud deployment setup.
