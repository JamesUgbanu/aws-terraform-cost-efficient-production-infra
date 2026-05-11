variable "identifier" {
  description = "DB instance identifier."
  type        = string
}

variable "db_name" {
  description = "Database name."
  type        = string
}

variable "username" {
  description = "Master username."
  type        = string
}

variable "password" {
  description = "Master password. In production, prefer passing this from a secret manager workflow."
  type        = string
  sensitive   = true
}

variable "engine_version" {
  description = "PostgreSQL engine version."
  type        = string
  default     = "17.2"
}

variable "instance_class" {
  description = "DB instance class."
  type        = string
  default     = "db.t4g.micro"
}

variable "allocated_storage" {
  description = "Initial allocated storage in GiB."
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Maximum autoscaled storage in GiB."
  type        = number
  default     = 100
}

variable "backup_retention_period" {
  description = "Backup retention period in days."
  type        = number
  default     = 7
}

variable "deletion_protection" {
  description = "Whether deletion protection should be enabled."
  type        = bool
  default     = true
}

variable "publicly_accessible" {
  description = "Whether the DB should be publicly accessible."
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Whether to enable Multi-AZ. Disabled by default for cost reasons."
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "Private subnet IDs for the database subnet group."
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "Security groups allowed to access the database."
  type        = list(string)
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot on destroy."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags to apply to database resources."
  type        = map(string)
  default     = {}
}
