output "alarm_names" {
  description = "CloudWatch alarm names created by this layer."
  value       = module.observability.alarm_names
}
