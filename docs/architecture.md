# Architecture

This repository models a production-conscious AWS stack for startup and small
SaaS teams that want reliable infrastructure without the weight of Kubernetes.

## Philosophy

- production-ready means predictable and recoverable, not complicated
- scale should come from clean separation and sensible defaults before it comes
  from more moving parts
- the first version should be cheap enough to keep running comfortably

## High-Level Design

See [assets/high-level-architecture.md](./assets/high-level-architecture.md) for
the rendered diagram.

Core building blocks:

- Route53 for DNS
- optional CloudFront for caching or static acceleration
- ALB for public ingress
- ECS Fargate API service for synchronous traffic
- ECS Fargate worker service for background work
- Lambda for bursty or short-lived jobs
- SQS for asynchronous decoupling
- RDS PostgreSQL for transactional persistence
- CloudWatch for logs and alarms
- ECR for container images
- GitHub Actions with OIDC for deployment

## Request Lifecycle

1. A client request resolves through Route53 and optionally CloudFront.
2. The ALB forwards traffic to the API ECS service.
3. The API service handles synchronous reads and writes against PostgreSQL.
4. Long-running or bursty work is sent to SQS or Lambda instead of blocking the
   request path.
5. Worker services consume queued work and update downstream state.

## Deployment Lifecycle

1. Terraform provisions each layer in sequence.
2. GitHub Actions assumes an AWS role using OIDC.
3. Application images are pushed to ECR.
4. ECS services roll forward through new task definitions with rollback
   protection via deployment circuit breakers.

## Scaling Path

- start with one API task and one worker task
- enable ECS autoscaling for the API when CPU becomes consistently elevated
- split workers by job type when queue contention or noisy neighbors appear
- add CloudFront when global latency or asset caching meaningfully matters
- consider Multi-AZ RDS when uptime requirements justify the added cost

## Reliability Considerations

- smaller Terraform states reduce blast radius
- ALB plus health checks protects the request path
- ECS deployment circuit breakers provide safer rollouts
- short CloudWatch retention controls cost without eliminating basic visibility
- database deletion protection is enabled by default

## Cost Tradeoffs

- NAT is disabled by default because it is one of the fastest ways to overspend
- X-Ray is disabled by default
- ECS Container Insights is intentionally disabled in this starter
- RDS starts small on `db.t4g.micro`
- observability stays inside a CloudWatch-only baseline

## When To Move To Kubernetes

Consider Kubernetes when several of these are true:

- you run many independently scaled services
- you need advanced scheduling or service mesh features
- you need portability across clouds or hybrid environments
- your platform team can absorb the extra operational load

Most early-stage teams are not there yet.

## When To Introduce Redis Or ElastiCache

Add Redis when:

- database-backed queues become a bottleneck
- you need low-latency caching
- rate limiting or session storage becomes hot-path work

Do not add it just because most diagrams have it.

## When To Separate Workers

Split workers earlier when:

- background jobs have very different memory or CPU profiles
- one queue type can starve others
- retries or dead-letter handling need dedicated controls

## When Lambda Is Appropriate

Lambda is a good fit for:

- burst jobs
- lightweight integrations
- webhook processors with short runtimes
- scheduled maintenance tasks
