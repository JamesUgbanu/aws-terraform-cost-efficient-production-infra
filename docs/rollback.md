# Rollback

## Terraform Rollback Principles

- prefer forward fixes over blind revert-and-apply cycles
- understand which layer owns the failing resource before changing state
- avoid mixing application rollbacks with database rollback decisions

## ECS Rollback

- ECS deployment circuit breakers are enabled
- rollback application images by redeploying the previous known-good tag
- keep a small recent image history in ECR for recovery

## Image Rollback

Recommended process:

1. identify the last healthy image tag
2. register a task definition that points back to it
3. redeploy the ECS service
4. verify health checks and logs

## Infrastructure Rollback Cautions

- some Terraform changes are not cleanly reversible
- security group, subnet, and database changes deserve extra care
- snapshot or export data before destructive database changes

## RDS Rollback Cautions

- restoring data usually means snapshot restore, not Terraform undo
- database schema migrations should always have their own rollback plan
- do not rely on `terraform destroy` semantics for production data recovery
