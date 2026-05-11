output "cluster_arn" {
  description = "ECS cluster ARN."
  value       = var.create_cluster ? aws_ecs_cluster.this[0].arn : var.cluster_arn
}

output "cluster_name" {
  description = "ECS cluster name."
  value       = var.create_cluster ? aws_ecs_cluster.this[0].name : element(reverse(split("/", var.cluster_arn)), 0)
}

output "service_arn" {
  description = "ECS service ARN."
  value       = aws_ecs_service.this.id
}

output "service_name" {
  description = "ECS service name."
  value       = aws_ecs_service.this.name
}

output "task_definition_arn" {
  description = "Task definition ARN."
  value       = aws_ecs_task_definition.this.arn
}

output "log_group_name" {
  description = "CloudWatch log group name."
  value       = aws_cloudwatch_log_group.this.name
}
