variable "name_prefix" {
  description = "Name prefix used for alarms and dashboard resources."
  type        = string
}

variable "log_group_names" {
  description = "CloudWatch log group names to ensure exist."
  type        = list(string)
  default     = []
}

variable "log_retention_days" {
  description = "Retention for managed CloudWatch log groups."
  type        = number
  default     = 7
}

variable "ecs_cluster_name" {
  description = "ECS cluster name for ECS alarms."
  type        = string
  default     = ""
}

variable "ecs_service_name" {
  description = "ECS service name for ECS alarms."
  type        = string
  default     = ""
}

variable "alb_arn_suffix" {
  description = "ALB ARN suffix used by ALB metrics."
  type        = string
  default     = ""
}

variable "rds_identifier" {
  description = "RDS identifier used by RDS alarms."
  type        = string
  default     = ""
}

variable "alarm_actions" {
  description = "SNS topic ARNs or other CloudWatch alarm actions."
  type        = list(string)
  default     = []
}

variable "enable_dashboard" {
  description = "Whether to create a simple CloudWatch dashboard."
  type        = bool
  default     = false
}

variable "enable_xray" {
  description = "Whether to provision X-Ray resources. Disabled by default to control cost."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags to apply to observability resources."
  type        = map(string)
  default     = {}
}
