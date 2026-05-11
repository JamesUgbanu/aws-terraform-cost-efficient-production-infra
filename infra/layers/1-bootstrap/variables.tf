variable "project_name" {
  description = "Project name used for naming and tagging."
  type        = string
  default     = "startup-infra"
}

variable "environment" {
  description = "Environment label for bootstrap tags."
  type        = string
  default     = "shared"
}

variable "aws_region" {
  description = "AWS region for bootstrap resources."
  type        = string
}

variable "enable_github_actions_oidc" {
  description = "Whether to create the shared GitHub Actions OIDC provider for the AWS account."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags applied to bootstrap resources."
  type        = map(string)
  default     = {}
}
