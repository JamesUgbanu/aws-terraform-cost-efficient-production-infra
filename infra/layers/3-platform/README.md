# Platform Layer

This layer owns shared runtime primitives that multiple services can consume.

Included here:

- ECR repositories
- the public ALB
- the default target group for the API service

This keeps container build and ingress concerns separate from the application
deployment layer.
