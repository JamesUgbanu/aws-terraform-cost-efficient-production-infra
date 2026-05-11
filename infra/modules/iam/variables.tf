variable "name_prefix" {
  description = "Prefix used for IAM resource names."
  type        = string
}

variable "create_oidc_provider" {
  description = "Whether to create the GitHub Actions OIDC provider."
  type        = bool
  default     = false
}

variable "create_github_actions_role" {
  description = "Whether to create the GitHub Actions deploy role."
  type        = bool
  default     = false
}

variable "create_ecs_roles" {
  description = "Whether to create ECS task execution and task roles."
  type        = bool
  default     = true
}

variable "github_repository_owner" {
  description = "GitHub organization or user that owns the repository."
  type        = string
  default     = ""
}

variable "github_repository_name" {
  description = "GitHub repository name allowed to assume the deploy role."
  type        = string
  default     = ""
}

variable "github_branch" {
  description = "Branch allowed to assume the deploy role."
  type        = string
  default     = "main"
}

variable "oidc_provider_arn" {
  description = "Existing GitHub OIDC provider ARN to reuse."
  type        = string
  default     = ""
}

variable "ecr_repository_arns" {
  description = "ECR repository ARNs that GitHub Actions can push to."
  type        = list(string)
  default     = []
}

variable "ecs_cluster_arns" {
  description = "ECS cluster ARNs that GitHub Actions can deploy to."
  type        = list(string)
  default     = []
}

variable "ecs_service_arns" {
  description = "ECS service ARNs that GitHub Actions can update."
  type        = list(string)
  default     = []
}

variable "ssm_parameter_arns" {
  description = "SSM parameter ARNs readable by ECS execution and task roles."
  type        = list(string)
  default     = []
}

variable "secrets_manager_arns" {
  description = "Secrets Manager ARNs readable by ECS execution and task roles."
  type        = list(string)
  default     = []
}

variable "task_policy_statements" {
  description = "Additional least-privilege policy statements attached to the ECS task role."
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "Additional tags to apply to IAM resources."
  type        = map(string)
  default     = {}
}
