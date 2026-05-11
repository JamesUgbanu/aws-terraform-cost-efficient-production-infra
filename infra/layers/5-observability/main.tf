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
        Layer       = "observability"
        ManagedBy   = "terraform"
      },
      var.tags
    )
  }
}

module "observability" {
  source = "../../modules/observability"

  name_prefix        = "${var.project_name}-${var.environment}"
  log_group_names    = compact([var.api_log_group_name, var.worker_log_group_name])
  log_retention_days = var.log_retention_days
  ecs_cluster_name   = var.ecs_cluster_name
  ecs_service_name   = var.ecs_service_name
  alb_arn_suffix     = var.alb_arn_suffix
  rds_identifier     = var.db_instance_identifier
  alarm_actions      = var.alarm_actions
  enable_dashboard   = var.enable_dashboard
  enable_xray        = false
  tags               = var.tags
}
