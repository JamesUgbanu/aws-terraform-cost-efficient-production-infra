variable "name" {
  description = "Base name used for networking resources."
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
  description = "CIDR blocks for public subnets. One subnet is created per CIDR."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets. Leave empty to skip private subnets."
  type        = list(string)
  default     = []
}

variable "enable_private_subnets" {
  description = "Whether private subnets should be created."
  type        = bool
  default     = true
}

variable "enable_nat_gateway" {
  description = "Whether to create a NAT gateway for private subnet egress. Disabled by default to reduce cost."
  type        = bool
  default     = false
}

variable "single_nat_gateway" {
  description = "Whether to create a single shared NAT gateway instead of one per AZ."
  type        = bool
  default     = true
}

variable "enable_vpc_endpoints" {
  description = "Whether to create low-cost VPC endpoints used by ECS in private subnets."
  type        = bool
  default     = false
}

variable "vpc_endpoint_services" {
  description = "Interface endpoint services to create when VPC endpoints are enabled."
  type        = list(string)
  default     = ["ecr.api", "ecr.dkr", "logs", "ssm", "kms"]
}

variable "tags" {
  description = "Additional tags to apply to networking resources."
  type        = map(string)
  default     = {}
}
