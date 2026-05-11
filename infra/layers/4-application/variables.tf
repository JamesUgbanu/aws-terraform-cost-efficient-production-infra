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
  description = "AWS region for application resources."
  type        = string
}

variable "github_oidc_provider_arn" {
  description = "ARN of the shared GitHub Actions OIDC provider."
  type        = string
}

variable "github_repository_owner" {
  description = "GitHub organization or user that owns this repository."
  type        = string
}

variable "github_repository_name" {
  description = "GitHub repository name allowed to deploy."
  type        = string
}

variable "github_branch" {
  description = "Branch allowed to deploy through GitHub Actions."
  type        = string
  default     = "main"
}

variable "api_repository_arn" {
  description = "ECR repository ARN for the API image."
  type        = string
}

variable "worker_repository_arn" {
  description = "Optional ECR repository ARN for the worker image."
  type        = string
  default     = ""
}

variable "alb_target_group_arn" {
  description = "ALB target group ARN used by the API service."
  type        = string
}

variable "app_subnet_ids" {
  description = "Subnet IDs used by ECS tasks."
  type        = list(string)
}

variable "db_subnet_ids" {
  description = "Subnet IDs used by the database."
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "Security group ID attached to ECS tasks."
  type        = string
}

variable "db_security_group_id" {
  description = "Security group ID attached to the database."
  type        = string
}

variable "assign_public_ip" {
  description = "Whether ECS tasks should receive public IPs."
  type        = bool
  default     = false
}

variable "api_image" {
  description = "Full image reference for the API service."
  type        = string
}

variable "api_container_name" {
  description = "Container name for the API service."
  type        = string
  default     = "api"
}

variable "api_container_port" {
  description = "Container port for the API service."
  type        = number
  default     = 3000
}

variable "api_cpu" {
  description = "API task CPU units."
  type        = number
  default     = 256
}

variable "api_memory" {
  description = "API task memory in MiB."
  type        = number
  default     = 512
}

variable "api_desired_count" {
  description = "Desired API task count."
  type        = number
  default     = 1
}

variable "api_health_check_command" {
  description = "Optional API container health check command."
  type        = list(string)
  default     = []
}

variable "api_environment_variables" {
  description = "Plain-text API environment variables."
  type        = map(string)
  default     = {}
}

variable "enable_api_autoscaling" {
  description = "Whether API autoscaling should be enabled."
  type        = bool
  default     = false
}

variable "api_autoscaling_min_capacity" {
  description = "Minimum API task count when autoscaling is enabled."
  type        = number
  default     = 1
}

variable "api_autoscaling_max_capacity" {
  description = "Maximum API task count when autoscaling is enabled."
  type        = number
  default     = 2
}

variable "api_autoscaling_cpu_target" {
  description = "CPU utilization target for API autoscaling."
  type        = number
  default     = 65
}

variable "enable_worker_service" {
  description = "Whether a separate ECS worker service should be deployed."
  type        = bool
  default     = true
}

variable "worker_image" {
  description = "Full image reference for the worker service."
  type        = string
  default     = ""
}

variable "worker_container_name" {
  description = "Container name for the worker service."
  type        = string
  default     = "worker"
}

variable "worker_cpu" {
  description = "Worker task CPU units."
  type        = number
  default     = 256
}

variable "worker_memory" {
  description = "Worker task memory in MiB."
  type        = number
  default     = 512
}

variable "worker_desired_count" {
  description = "Desired worker task count."
  type        = number
  default     = 1
}

variable "worker_environment_variables" {
  description = "Plain-text worker environment variables."
  type        = map(string)
  default     = {}
}

variable "ssm_secret_arns" {
  description = "Map of environment variable names to SSM parameter ARNs."
  type        = map(string)
  default     = {}
}

variable "secrets_manager_secret_arns" {
  description = "Map of environment variable names to Secrets Manager ARNs."
  type        = map(string)
  default     = {}
}

variable "additional_task_policy_statements" {
  description = "Optional additional least-privilege IAM policy statements for the task role."
  type        = list(any)
  default     = []
}

variable "enable_execute_command" {
  description = "Whether ECS Exec should be enabled."
  type        = bool
  default     = true
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days."
  type        = number
  default     = 7
}

variable "enable_rds_postgres" {
  description = "Whether a PostgreSQL database should be created."
  type        = bool
  default     = true
}

variable "db_name" {
  description = "Database name."
  type        = string
  default     = "app"
}

variable "db_username" {
  description = "Database username."
  type        = string
  default     = "app_user"
}

variable "db_password" {
  description = "Database password."
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t4g.micro"
}

variable "db_allocated_storage" {
  description = "Initial RDS allocated storage in GiB."
  type        = number
  default     = 20
}

variable "db_max_allocated_storage" {
  description = "Maximum RDS autoscaled storage in GiB."
  type        = number
  default     = 100
}

variable "db_backup_retention_period" {
  description = "RDS backup retention period in days."
  type        = number
  default     = 7
}

variable "db_deletion_protection" {
  description = "Whether deletion protection should be enabled for the database."
  type        = bool
  default     = true
}

variable "db_multi_az" {
  description = "Whether Multi-AZ should be enabled."
  type        = bool
  default     = false
}

variable "db_skip_final_snapshot" {
  description = "Whether to skip the final DB snapshot on destroy."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags applied to application resources."
  type        = map(string)
  default     = {}
}
