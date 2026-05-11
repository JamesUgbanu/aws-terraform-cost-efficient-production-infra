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
  description = "AWS region for platform resources."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where platform resources should be created."
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs used by the ALB."
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security group ID attached to the ALB."
  type        = string
}

variable "api_repository_name" {
  description = "ECR repository name for the API service."
  type        = string
}

variable "enable_worker_repository" {
  description = "Whether to create a separate worker ECR repository."
  type        = bool
  default     = true
}

variable "worker_repository_name" {
  description = "ECR repository name for the worker service."
  type        = string
  default     = "worker"
}

variable "ecr_max_image_count" {
  description = "Maximum number of tagged images retained in ECR."
  type        = number
  default     = 30
}

variable "api_container_port" {
  description = "API container port attached to the ALB target group."
  type        = number
  default     = 3000
}

variable "api_health_check_path" {
  description = "Health check path for the API target group."
  type        = string
  default     = "/health"
}

variable "certificate_arn" {
  description = "Optional ACM certificate ARN to enable HTTPS."
  type        = string
  default     = ""
}

variable "enable_alb_deletion_protection" {
  description = "Whether the ALB should use deletion protection."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags applied to platform resources."
  type        = map(string)
  default     = {}
}
