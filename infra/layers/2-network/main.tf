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
        Layer       = "network"
        ManagedBy   = "terraform"
      },
      var.tags
    )
  }
}

module "networking" {
  source = "../../modules/networking"

  name                   = "${var.project_name}-${var.environment}"
  vpc_cidr               = var.vpc_cidr
  availability_zones     = var.availability_zones
  public_subnet_cidrs    = var.public_subnet_cidrs
  private_subnet_cidrs   = var.private_subnet_cidrs
  enable_private_subnets = var.enable_private_subnets
  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = var.single_nat_gateway
  enable_vpc_endpoints   = var.enable_vpc_endpoints
  tags                   = var.tags
}
