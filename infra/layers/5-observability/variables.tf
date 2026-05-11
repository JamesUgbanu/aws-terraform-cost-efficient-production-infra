variable "project_name" {
  description = "Project name used for naming and tagging."
  type        = string
  default     = "startup-infra"
}

variable "environment" {
  description = "Deployment environment, such as dev or prod."
  type        = string
}

variable "aws_region" {
  description = "AWS region for observability resources."
  type        = string
}

variable "api_log_group_name" {
  description = "API CloudWatch log group name."
  type        = string
  default     = ""
}

variable "worker_log_group_name" {
  description = "Worker CloudWatch log group name."
  type        = string
  default     = ""
}

variable "ecs_cluster_name" {
  description = "ECS cluster name for ECS alarms."
  type        = string
  default     = ""
}

variable "ecs_service_name" {
  description = "Primary ECS service name for ECS alarms."
  type        = string
  default     = ""
}

variable "alb_arn_suffix" {
  description = "ALB ARN suffix used by CloudWatch ApplicationELB metrics."
  type        = string
  default     = ""
}

variable "db_instance_identifier" {
  description = "RDS instance identifier."
  type        = string
  default     = ""
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days."
  type        = number
  default     = 7
}

variable "alarm_actions" {
  description = "SNS topic ARNs or similar CloudWatch alarm actions."
  type        = list(string)
  default     = []
}

variable "enable_dashboard" {
  description = "Whether a simple CloudWatch dashboard should be created."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags applied to observability resources."
  type        = map(string)
  default     = {}
}
