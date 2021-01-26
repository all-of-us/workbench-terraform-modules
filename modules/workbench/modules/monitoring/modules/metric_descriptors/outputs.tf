output "monitoring_metric_id_to_name" {
  description = "The generated monitoring metric id to monitoring metric name map"

  value       = {
  for metric_descriptor in google_monitoring_metric_descriptor.metric_descriptor:
  metric_descriptor.id => metric_descriptor.display_name
  }
}

output "logging_metric_id_to_name" {
  description = "The generated logging metric id to logging metric name map"

  value       = {
  for logging_metric in google_logging_metric.logging_metric:
  logging_metric.id => logging_metric.name
  }
}
