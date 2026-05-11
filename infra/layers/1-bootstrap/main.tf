terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = merge(
      {
        Project     = var.project_name
        Environment = var.environment
        Layer       = "bootstrap"
        ManagedBy   = "terraform"
      },
      var.tags
    )
  }
}

module "iam" {
  source = "../../modules/iam"

  name_prefix                = "${var.project_name}-${var.environment}"
  create_oidc_provider       = var.enable_github_actions_oidc
  create_github_actions_role = false
  create_ecs_roles           = false
  tags                       = var.tags
}
