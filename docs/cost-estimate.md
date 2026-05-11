# Cost Estimate

This starter is designed to make a real production path possible in roughly the
`$60 to $100/month` range for an early-stage workload, assuming modest traffic
and disciplined feature choices.

## Rough Monthly Baseline

| Service | Monthly estimate |
| --- | --- |
| ECS Fargate API service | `$10 to $25` |
| ECS Fargate worker service | `$10 to $25` |
| ALB | `$18 to $25` |
| RDS PostgreSQL `db.t4g.micro` | `$15 to $30` |
| CloudWatch logs and alarms | `$5 to $10` |
| ECR, secrets, and storage | `$1 to $5` |

## Biggest Cost Traps

- NAT Gateway: often `$30+` per month before meaningful traffic
- excessive CloudWatch log retention
- enabling too many detailed metrics or third-party observability tools too early
- jumping to Multi-AZ RDS before the business requires it

## How To Stay Under `$60 to $100`

- keep NAT disabled unless private subnet egress is truly required
- start with one API task and one worker task
- prefer SQS for background jobs before adding Redis or ElastiCache
- keep CPU and memory defaults small until profiling says otherwise
- keep log retention at `7` or `14` days
- use one ALB, not one per service
- skip CloudFront until it solves a real problem

## Observability Budget Guidance

To keep observability near `$5 to $10/month`:

- use CloudWatch only at the start
- limit alarms to a small core set
- avoid verbose debug logs in production
- rotate logs aggressively
- leave X-Ray disabled by default

## NAT Gateway Warning

The NAT Gateway is the most common cost surprise in small AWS environments.
This repo supports it, but leaves it off by default on purpose.
