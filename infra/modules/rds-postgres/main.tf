resource "aws_db_subnet_group" "this" {
  name       = "${var.identifier}-subnets"
  subnet_ids = var.subnet_ids

  tags = merge(
    {
      Name = "${var.identifier}-subnets"
    },
    var.tags
  )
}

resource "aws_db_instance" "this" {
  identifier                      = var.identifier
  engine                          = "postgres"
  engine_version                  = var.engine_version
  instance_class                  = var.instance_class
  allocated_storage               = var.allocated_storage
  max_allocated_storage           = var.max_allocated_storage
  storage_type                    = "gp3"
  storage_encrypted               = true
  db_name                         = var.db_name
  username                        = var.username
  password                        = var.password
  db_subnet_group_name            = aws_db_subnet_group.this.name
  vpc_security_group_ids          = var.vpc_security_group_ids
  publicly_accessible             = var.publicly_accessible
  backup_retention_period         = var.backup_retention_period
  deletion_protection             = var.deletion_protection
  multi_az                        = var.multi_az
  skip_final_snapshot             = var.skip_final_snapshot
  auto_minor_version_upgrade      = true
  apply_immediately               = false
  copy_tags_to_snapshot           = true
  enabled_cloudwatch_logs_exports = ["postgresql"]

  performance_insights_enabled = false

  tags = merge(
    {
      Name = var.identifier
    },
    var.tags
  )
}
