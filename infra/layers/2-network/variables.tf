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
  description = "AWS region for networking resources."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "availability_zones" {
  description = "Availability zones used for subnet placement."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs."
  type        = list(string)
  default     = []
}

variable "enable_private_subnets" {
  description = "Whether private subnets should be created."
  type        = bool
  default     = true
}

variable "enable_nat_gateway" {
  description = "Whether a NAT gateway should be created."
  type        = bool
  default     = false
}

variable "single_nat_gateway" {
  description = "Whether to create a single shared NAT gateway."
  type        = bool
  default     = true
}

variable "enable_vpc_endpoints" {
  description = "Whether low-cost VPC endpoints should be created for ECS private subnet access."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags applied to networking resources."
  type        = map(string)
  default     = {}
}
