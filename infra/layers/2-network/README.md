# Network Layer

This layer owns the VPC, subnets, routing, optional NAT, baseline security
groups, and optional VPC endpoints.

Cost philosophy:

- public subnets plus ALB are standard
- private subnets are supported
- NAT is disabled by default because it quickly becomes one of the first
  surprise infrastructure costs for a small team
