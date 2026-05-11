output "github_oidc_provider_arn" {
  description = "ARN of the shared GitHub Actions OIDC provider."
  value       = module.iam.oidc_provider_arn
}
