# Observability Layer

This layer keeps monitoring intentionally lean.

Included:

- short-retention CloudWatch log groups
- ECS CPU and memory alarms
- ALB 5xx alarm
- RDS CPU and free storage alarms
- an optional basic dashboard

Excluded by default:

- X-Ray
- high-cardinality metrics pipelines
- third-party APM subscriptions
