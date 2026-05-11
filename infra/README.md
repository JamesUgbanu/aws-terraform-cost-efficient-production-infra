# Infrastructure

This repository uses a layered Terraform model designed for production-minded
startup teams.

The structure is intentionally close to a mature real-world setup:

- reusable modules
- separate layers with smaller state files
- explicit bootstrap, network, platform, application, and observability
  ownership boundaries
- local-state friendly for learning
- clear path to S3 + DynamoDB remote state

High-level structure:

```text
infra/
  modules/
  layers/
    1-bootstrap/
    2-network/
    3-platform/
    4-application/
    5-observability/
  examples/
```
