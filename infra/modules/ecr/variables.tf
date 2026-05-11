variable "repository_name" {
  description = "Name of the ECR repository."
  type        = string
}

variable "image_tag_mutability" {
  description = "Whether image tags are mutable or immutable."
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Whether image scanning should run on push."
  type        = bool
  default     = true
}

variable "untagged_image_days" {
  description = "Days to retain untagged images before cleanup."
  type        = number
  default     = 7
}

variable "max_image_count" {
  description = "Maximum number of tagged images to retain."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Additional tags for the repository."
  type        = map(string)
  default     = {}
}
