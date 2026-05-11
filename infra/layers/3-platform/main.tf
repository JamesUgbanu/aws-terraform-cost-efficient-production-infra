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
        Layer       = "platform"
        ManagedBy   = "terraform"
      },
      var.tags
    )
  }
}

module "ecr_api" {
  source = "../../modules/ecr"

  repository_name = var.api_repository_name
  max_image_count = var.ecr_max_image_count
  tags            = var.tags
}

module "ecr_worker" {
  count  = var.enable_worker_repository ? 1 : 0
  source = "../../modules/ecr"

  repository_name = var.worker_repository_name
  max_image_count = var.ecr_max_image_count
  tags            = var.tags
}

module "alb" {
  source = "../../modules/alb"

  name                       = "${var.project_name}-${var.environment}-alb"
  vpc_id                     = var.vpc_id
  subnet_ids                 = var.public_subnet_ids
  security_group_ids         = [var.alb_security_group_id]
  target_port                = var.api_container_port
  health_check_path          = var.api_health_check_path
  certificate_arn            = var.certificate_arn
  enable_deletion_protection = var.enable_alb_deletion_protection
  tags                       = var.tags
}
