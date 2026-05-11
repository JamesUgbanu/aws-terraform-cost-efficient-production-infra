output "github_actions_role_arn" {
  description = "IAM role ARN used by GitHub Actions for deployment."
  value       = module.iam.github_actions_role_arn
}

output "ecs_cluster_name" {
  description = "ECS cluster name."
  value       = module.api_service.cluster_name
}

output "ecs_service_name" {
  description = "API ECS service name."
  value       = module.api_service.service_name
}

output "ecs_task_definition_arn" {
  description = "API task definition ARN."
  value       = module.api_service.task_definition_arn
}

output "api_log_group_name" {
  description = "API CloudWatch log group name."
  value       = module.api_service.log_group_name
}

output "worker_log_group_name" {
  description = "Worker CloudWatch log group name."
  value       = try(module.worker_service[0].log_group_name, null)
}

output "db_instance_identifier" {
  description = "RDS instance identifier."
  value       = try(module.database[0].db_instance_identifier, null)
}

output "db_endpoint" {
  description = "RDS endpoint."
  value       = try(module.database[0].db_endpoint, null)
}
