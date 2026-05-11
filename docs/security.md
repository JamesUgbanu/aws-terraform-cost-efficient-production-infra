# Security

## Security Philosophy

- least privilege first
- private by default where cost and simplicity allow
- no long-lived AWS keys in CI
- no secrets committed to the repository

## IAM

- ECS uses separate task execution and task roles
- GitHub Actions deploys through OIDC role assumption
- policies are intentionally narrow and easier to audit than broad admin roles

## Network Controls

- the ALB accepts internet traffic
- the ECS security group allows app traffic only from the ALB baseline group
- the database security group allows PostgreSQL only from ECS
- RDS public access is disabled by default

## Secrets Handling

- prefer SSM Parameter Store or AWS Secrets Manager
- pass only ARNs into Terraform where practical
- avoid storing production secrets in `terraform.tfvars`

## Backup Guidance

- keep RDS backups enabled
- use a longer retention window for regulated workloads
- practice restore drills before calling a system production-ready

## Deletion Protection

- ALB deletion protection is enabled by default
- RDS deletion protection is enabled by default
- disable these only deliberately and with review
