output "oidc_provider_arn" {
  description = "GitHub Actions OIDC provider ARN."
  value       = var.create_oidc_provider ? aws_iam_openid_connect_provider.github[0].arn : var.oidc_provider_arn
}

output "github_actions_role_arn" {
  description = "GitHub Actions role ARN."
  value       = try(aws_iam_role.github_actions[0].arn, null)
}

output "ecs_task_execution_role_arn" {
  description = "ECS task execution role ARN."
  value       = try(aws_iam_role.ecs_task_execution[0].arn, null)
}

output "ecs_task_role_arn" {
  description = "ECS task role ARN."
  value       = try(aws_iam_role.ecs_task[0].arn, null)
}
