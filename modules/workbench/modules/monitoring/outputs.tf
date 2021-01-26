output "logging_metric_id_to_name" {
  description = "The generated logging metric id to logging metric name map"
  value = module.metric_descriptors.logging_metric_id_to_name
}
output "monitoring_metric_id_to_name" {
  description = "The generated monitoring metric id to monitoring metric name map"
  value = module.metric_descriptors.monitoring_metric_id_to_name
}
output "policy_id_to_name" {
  description = "The generated policy id to policy name map"
  value = module.alert_policies.policy_id_to_name
}
output "dashboard_id_to_json" {
  description = "The generated dashboard id to json input"
  value = module.dashboards.dashboard_id_to_json
}
