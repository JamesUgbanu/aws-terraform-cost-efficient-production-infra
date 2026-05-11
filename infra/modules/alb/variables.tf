variable "name" {
  description = "Name of the Application Load Balancer."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ALB and target group should be created."
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for the ALB."
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups attached to the ALB."
  type        = list(string)
}

variable "target_port" {
  description = "Port used by the target group."
  type        = number
  default     = 3000
}

variable "health_check_path" {
  description = "Path used by the target group health check."
  type        = string
  default     = "/health"
}

variable "health_check_matcher" {
  description = "HTTP matcher used by the target group health check."
  type        = string
  default     = "200-399"
}

variable "certificate_arn" {
  description = "Optional ACM certificate ARN to enable HTTPS."
  type        = string
  default     = ""
}

variable "enable_deletion_protection" {
  description = "Whether ALB deletion protection should be enabled."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags to apply to ALB resources."
  type        = map(string)
  default     = {}
}
