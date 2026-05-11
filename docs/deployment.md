# Deployment

## Local Terraform Workflow

Apply layers in this order:

1. `infra/layers/1-bootstrap`
2. `infra/layers/2-network`
3. `infra/layers/3-platform`
4. `infra/layers/4-application`
5. `infra/layers/5-observability`

Typical commands:

```bash
cd infra/layers/2-network
cp backend.tf.example backend.tf
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

## GitHub Actions Deployment

- `terraform-plan.yml` runs on pull requests
- `terraform-apply.yml` runs on merge to `main` or manual dispatch
- both workflows assume AWS roles via GitHub OIDC

## ECR Push Workflow

This repo includes Terraform for ECR, but container build and push steps are
usually handled by your application repository or an extended workflow.

Recommended image tags:

- `sha-<commit>`
- `latest` for fast rollback convenience only if your team is disciplined

## ECS Deployment Flow

1. Build image
2. Push image to ECR
3. Register a new ECS task definition revision
4. Update the ECS service
5. Let ECS wait for healthy replacement tasks

## Environment Variable Handling

- commit only non-secret defaults
- store real secrets in SSM or Secrets Manager
- reference secret ARNs in the application layer
