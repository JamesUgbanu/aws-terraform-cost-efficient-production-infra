# Application Layer

This layer owns deployable application resources:

- IAM roles for ECS tasks and GitHub Actions deployment
- the API ECS Fargate service
- the optional worker ECS Fargate service
- the PostgreSQL database

Why it stays separate:

- deploy-time concerns should be easier to reason about than networking
- service changes happen more frequently than VPC changes
- database protection settings deserve their own review surface
