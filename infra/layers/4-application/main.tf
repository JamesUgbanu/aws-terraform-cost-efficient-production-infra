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
        Layer       = "application"
        ManagedBy   = "terraform"
      },
      var.tags
    )
  }
}

module "iam" {
  source = "../../modules/iam"

  name_prefix                = "${var.project_name}-${var.environment}"
  create_oidc_provider       = false
  create_github_actions_role = true
  create_ecs_roles           = true
  github_repository_owner    = var.github_repository_owner
  github_repository_name     = var.github_repository_name
  github_branch              = var.github_branch
  oidc_provider_arn          = var.github_oidc_provider_arn
  ecr_repository_arns        = compact([var.api_repository_arn, var.worker_repository_arn])
  ecs_cluster_arns           = []
  ecs_service_arns           = []
  ssm_parameter_arns         = values(var.ssm_secret_arns)
  secrets_manager_arns       = values(var.secrets_manager_secret_arns)
  task_policy_statements     = var.additional_task_policy_statements
  tags                       = var.tags
}

module "api_service" {
  source = "../../modules/ecs-fargate"

  name                        = "${var.project_name}-${var.environment}-api"
  cluster_name                = "${var.project_name}-${var.environment}"
  container_name              = var.api_container_name
  image                       = var.api_image
  container_port              = var.api_container_port
  cpu                         = var.api_cpu
  memory                      = var.api_memory
  desired_count               = var.api_desired_count
  subnet_ids                  = var.app_subnet_ids
  security_group_ids          = [var.ecs_security_group_id]
  assign_public_ip            = var.assign_public_ip
  target_group_arn            = var.alb_target_group_arn
  health_check_command        = var.api_health_check_command
  environment_variables       = var.api_environment_variables
  secret_arns                 = merge(var.ssm_secret_arns, var.secrets_manager_secret_arns)
  log_retention_days          = var.log_retention_days
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  ecs_task_role_arn           = module.iam.ecs_task_role_arn
  enable_execute_command      = var.enable_execute_command
  enable_autoscaling          = var.enable_api_autoscaling
  autoscaling_min_capacity    = var.api_autoscaling_min_capacity
  autoscaling_max_capacity    = var.api_autoscaling_max_capacity
  autoscaling_cpu_target      = var.api_autoscaling_cpu_target
  tags                        = var.tags
}

module "worker_service" {
  count  = var.enable_worker_service ? 1 : 0
  source = "../../modules/ecs-fargate"

  name                        = "${var.project_name}-${var.environment}-worker"
  cluster_name                = "${var.project_name}-${var.environment}"
  create_cluster              = false
  cluster_arn                 = module.api_service.cluster_arn
  container_name              = var.worker_container_name
  image                       = var.worker_image
  cpu                         = var.worker_cpu
  memory                      = var.worker_memory
  desired_count               = var.worker_desired_count
  subnet_ids                  = var.app_subnet_ids
  security_group_ids          = [var.ecs_security_group_id]
  assign_public_ip            = var.assign_public_ip
  environment_variables       = var.worker_environment_variables
  secret_arns                 = merge(var.ssm_secret_arns, var.secrets_manager_secret_arns)
  log_retention_days          = var.log_retention_days
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  ecs_task_role_arn           = module.iam.ecs_task_role_arn
  enable_execute_command      = var.enable_execute_command
  enable_autoscaling          = false
  is_worker                   = true
  tags                        = var.tags
}

module "database" {
  count  = var.enable_rds_postgres ? 1 : 0
  source = "../../modules/rds-postgres"

  identifier              = "${var.project_name}-${var.environment}-postgres"
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  max_allocated_storage   = var.db_max_allocated_storage
  backup_retention_period = var.db_backup_retention_period
  deletion_protection     = var.db_deletion_protection
  publicly_accessible     = false
  multi_az                = var.db_multi_az
  subnet_ids              = var.db_subnet_ids
  vpc_security_group_ids  = [var.db_security_group_id]
  skip_final_snapshot     = var.db_skip_final_snapshot
  tags                    = var.tags
}
