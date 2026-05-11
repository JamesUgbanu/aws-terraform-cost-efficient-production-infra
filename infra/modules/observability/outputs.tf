output "alarm_names" {
  description = "Names of the CloudWatch alarms created by this module."
  value = compact([
    try(aws_cloudwatch_metric_alarm.ecs_cpu_high[0].alarm_name, null),
    try(aws_cloudwatch_metric_alarm.ecs_memory_high[0].alarm_name, null),
    try(aws_cloudwatch_metric_alarm.alb_5xx_high[0].alarm_name, null),
    try(aws_cloudwatch_metric_alarm.rds_cpu_high[0].alarm_name, null),
    try(aws_cloudwatch_metric_alarm.rds_storage_low[0].alarm_name, null)
  ])
}
