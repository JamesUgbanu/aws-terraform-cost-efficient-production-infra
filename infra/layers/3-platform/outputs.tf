output "api_repository_arn" {
  description = "API ECR repository ARN."
  value       = module.ecr_api.repository_arn
}

output "api_repository_url" {
  description = "API ECR repository URL."
  value       = module.ecr_api.repository_url
}

output "worker_repository_arn" {
  description = "Worker ECR repository ARN."
  value       = try(module.ecr_worker[0].repository_arn, null)
}

output "worker_repository_url" {
  description = "Worker ECR repository URL."
  value       = try(module.ecr_worker[0].repository_url, null)
}

output "alb_arn" {
  description = "ALB ARN."
  value       = module.alb.alb_arn
}

output "alb_dns_name" {
  description = "ALB DNS name."
  value       = module.alb.alb_dns_name
}

output "alb_zone_id" {
  description = "ALB Route53 zone ID."
  value       = module.alb.alb_zone_id
}

output "alb_target_group_arn" {
  description = "API ALB target group ARN."
  value       = module.alb.target_group_arn
}
