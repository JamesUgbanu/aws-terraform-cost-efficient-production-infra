# NestJS API Example

This starter fits a typical NestJS API with:

- one ALB-backed ECS Fargate API service
- one PostgreSQL database
- optional worker service
- SSM and Secrets Manager for runtime secrets

Suggested starting values:

- `api_container_port = 3000`
- `api_cpu = 256`
- `api_memory = 512`
- `api_desired_count = 1`
- `db_instance_class = "db.t4g.micro"`

Recommended environment variables:

- `NODE_ENV=production`
- `PORT=3000`
- `LOG_LEVEL=info`
- `APP_BASE_URL=https://api.example.com`
