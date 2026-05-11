variable "name" {
  description = "Base name used for ECS resources."
  type        = string
}

variable "cluster_name" {
  description = "Name of the ECS cluster."
  type        = string
}

variable "create_cluster" {
  description = "Whether the module should create the ECS cluster."
  type        = bool
  default     = true
}

variable "cluster_arn" {
  description = "Existing ECS cluster ARN to reuse when create_cluster is false."
  type        = string
  default     = ""
}

variable "container_name" {
  description = "Container name in the task definition."
  type        = string
}

variable "image" {
  description = "Container image reference."
  type        = string
}

variable "container_port" {
  description = "Container port exposed by the service."
  type        = number
  default     = 3000
}

variable "cpu" {
  description = "Task CPU units."
  type        = number
  default     = 256
}

variable "memory" {
  description = "Task memory in MiB."
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Desired task count."
  type        = number
  default     = 1
}

variable "subnet_ids" {
  description = "Subnet IDs used by the ECS service."
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security group IDs attached to the service."
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Whether tasks should receive public IPs."
  type        = bool
  default     = false
}

variable "target_group_arn" {
  description = "Optional target group ARN for a load-balanced service."
  type        = string
  default     = ""
}

variable "health_check_command" {
  description = "Optional container health check command."
  type        = list(string)
  default     = []
}

variable "environment_variables" {
  description = "Plain-text environment variables passed to the container."
  type        = map(string)
  default     = {}
}

variable "secret_arns" {
  description = "Map of environment variable names to SSM or Secrets Manager ARNs."
  type        = map(string)
  default     = {}
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days."
  type        = number
  default     = 7
}

variable "ecs_task_execution_role_arn" {
  description = "Existing ECS task execution role ARN."
  type        = string
}

variable "ecs_task_role_arn" {
  description = "Existing ECS task role ARN."
  type        = string
}

variable "enable_execute_command" {
  description = "Whether ECS Exec should be enabled."
  type        = bool
  default     = true
}

variable "enable_autoscaling" {
  description = "Whether service autoscaling should be enabled."
  type        = bool
  default     = false
}

variable "autoscaling_min_capacity" {
  description = "Minimum task count when autoscaling is enabled."
  type        = number
  default     = 1
}

variable "autoscaling_max_capacity" {
  description = "Maximum task count when autoscaling is enabled."
  type        = number
  default     = 2
}

variable "autoscaling_cpu_target" {
  description = "Target ECS CPU utilization percentage."
  type        = number
  default     = 65
}

variable "is_worker" {
  description = "Whether this service is a worker without ALB attachment."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags to apply to ECS resources."
  type        = map(string)
  default     = {}
}
