output "bigquery_dataset" {
  value = module.reporting.bigquery_dataset
}

output "bigquery_views" {
  value = module.reporting.bigquery_views
}

output "table_names" {
  value = module.reporting.table_names
}

# Egress Alert
output "egress_alert_rendered_queries" {
  value = module.egress_detection.egress_alert_rendered_queries
}

# Monitoring
output "logging_metric_id_to_name" {
  description = "The generated logging metric id to logging metric name map"
  value = module.monitoring.logging_metric_id_to_name
}
output "monitoring_metric_id_to_name" {
  description = "The generated monitoring metric id to monitoring metric name map"
  value = module.monitoring.monitoring_metric_id_to_name
}
output "policy_id_to_name" {
  description = "The generated policy id to policy name map"
  value = module.monitoring.policy_id_to_name
}
output "dashboard_id_to_json" {
  description = "The generated dashboard id to json input"
  value = module.monitoring.dashboard_id_to_json
}