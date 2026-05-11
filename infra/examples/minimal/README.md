# Minimal Deploy Example

This is the fastest realistic path for trying the repo with a small production
or staging environment.

## What This Example Assumes

- one ECS Fargate API service
- optional single worker service
- one RDS PostgreSQL instance
- one shared ALB
- no NAT Gateway at first
- no Redis at first
- CloudWatch-only observability

## Order Of Operations

1. Apply `infra/layers/1-bootstrap`
2. Apply `infra/layers/2-network`
3. Apply `infra/layers/3-platform`
4. Apply `infra/layers/4-application`
5. Apply `infra/layers/5-observability`

## Commands

```bash
cd ../../layers/1-bootstrap
cp backend.tf.example backend.tf
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

Repeat for the remaining layers after replacing placeholder values.

## Lowest-Cost Starting Shape

- `enable_nat_gateway = false`
- `api_cpu = 256`
- `api_memory = 512`
- `api_desired_count = 1`
- `worker_cpu = 256`
- `worker_memory = 512`
- `worker_desired_count = 0` if you do not need async jobs yet
- `db_instance_class = "db.t4g.micro"`
- `log_retention_days = 7`

## What To Fill In First

- AWS region
- GitHub repository owner and name
- VPC subnet values
- ACM certificate ARN if enabling HTTPS
- ECR repository values
- database password through a secure input path
- SSM or Secrets Manager ARNs for runtime secrets
