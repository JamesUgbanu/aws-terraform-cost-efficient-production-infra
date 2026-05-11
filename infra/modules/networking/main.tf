locals {
  private_subnets_enabled = var.enable_private_subnets && length(var.private_subnet_cidrs) > 0
  nat_gateway_enabled     = local.private_subnets_enabled && var.enable_nat_gateway
  nat_gateway_count       = local.nat_gateway_enabled ? (var.single_nat_gateway ? 1 : length(var.public_subnet_cidrs)) : 0
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      Name = "${var.name}-igw"
    },
    var.tags
  )
}

resource "aws_subnet" "public" {
  for_each = {
    for index, cidr in var.public_subnet_cidrs : index => {
      cidr = cidr
      az   = var.availability_zones[index]
    }
  }

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = "${var.name}-public-${each.value.az}"
      Tier = "public"
    },
    var.tags
  )
}

resource "aws_subnet" "private" {
  for_each = local.private_subnets_enabled ? {
    for index, cidr in var.private_subnet_cidrs : index => {
      cidr = cidr
      az   = var.availability_zones[index]
    }
  } : {}

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = merge(
    {
      Name = "${var.name}-private-${each.value.az}"
      Tier = "private"
    },
    var.tags
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(
    {
      Name = "${var.name}-public-rt"
    },
    var.tags
  )
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  count  = local.nat_gateway_count
  domain = "vpc"

  tags = merge(
    {
      Name = "${var.name}-nat-eip-${count.index + 1}"
    },
    var.tags
  )
}

resource "aws_nat_gateway" "this" {
  count = local.nat_gateway_count

  allocation_id = aws_eip.nat[count.index].id
  subnet_id = values(aws_subnet.public)[
    var.single_nat_gateway ? 0 : count.index
  ].id

  tags = merge(
    {
      Name = "${var.name}-nat-${count.index + 1}"
    },
    var.tags
  )

  depends_on = [aws_internet_gateway.this]
}

resource "aws_route_table" "private" {
  for_each = aws_subnet.private

  vpc_id = aws_vpc.this.id

  dynamic "route" {
    for_each = local.nat_gateway_enabled ? [1] : []
    content {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.this[
        var.single_nat_gateway ? 0 : tonumber(each.key)
      ].id
    }
  }

  tags = merge(
    {
      Name = "${var.name}-private-rt-${each.value.availability_zone}"
    },
    var.tags
  )
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}

resource "aws_security_group" "alb" {
  name_prefix = "${var.name}-alb-"
  description = "Baseline ALB security group."
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP from the internet"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS from the internet"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "${var.name}-alb-sg"
    },
    var.tags
  )
}

resource "aws_security_group" "ecs" {
  name_prefix = "${var.name}-ecs-"
  description = "Baseline ECS service security group."
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
    description     = "Application traffic from the ALB"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "${var.name}-ecs-sg"
    },
    var.tags
  )
}

resource "aws_security_group" "db" {
  name_prefix = "${var.name}-db-"
  description = "Baseline database security group."
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs.id]
    description     = "PostgreSQL from ECS services"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "${var.name}-db-sg"
    },
    var.tags
  )
}

resource "aws_security_group" "endpoints" {
  count = var.enable_vpc_endpoints && local.private_subnets_enabled ? 1 : 0

  name_prefix = "${var.name}-vpce-"
  description = "Security group for interface VPC endpoints."
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs.id]
    description     = "HTTPS from ECS tasks"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "${var.name}-vpce-sg"
    },
    var.tags
  )
}

resource "aws_vpc_endpoint" "interface" {
  for_each = var.enable_vpc_endpoints && local.private_subnets_enabled ? toset(var.vpc_endpoint_services) : []

  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.${data.aws_region.current.region}.${each.value}"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [for subnet in aws_subnet.private : subnet.id]
  security_group_ids  = [aws_security_group.endpoints[0].id]
  private_dns_enabled = true

  tags = merge(
    {
      Name = "${var.name}-${replace(each.value, ".", "-")}-endpoint"
    },
    var.tags
  )
}

data "aws_region" "current" {}
