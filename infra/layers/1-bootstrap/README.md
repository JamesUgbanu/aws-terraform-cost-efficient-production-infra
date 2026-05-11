# Bootstrap Layer

This layer owns shared account-level Terraform plumbing that should exist
before runtime resources.

Right now it includes:

- the GitHub Actions OIDC provider for AWS role assumption

Later it can also own:

- remote state buckets
- lock tables
- organization-wide IAM guardrails
