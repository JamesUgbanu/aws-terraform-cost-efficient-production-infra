output "vpc_id" {
  description = "VPC ID."
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs."
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs."
  value       = module.networking.private_subnet_ids
}

output "alb_security_group_id" {
  description = "Baseline ALB security group ID."
  value       = module.networking.alb_security_group_id
}

output "ecs_security_group_id" {
  description = "Baseline ECS security group ID."
  value       = module.networking.ecs_security_group_id
}

output "db_security_group_id" {
  description = "Baseline database security group ID."
  value       = module.networking.db_security_group_id
}
