# API Worker Example

Use the worker pattern when you need:

- background jobs
- queue consumers
- webhooks that should fan out into async work
- report generation

Recommended shape:

- keep the API service ALB-backed
- keep the worker service off the ALB
- connect jobs through SQS
- autoscale the API first, then scale workers separately when queue depth grows
