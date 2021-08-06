module "metric_descriptors" {
  source     = "./modules/metric_descriptors"
  aou_env    = var.aou_env
  project_id = var.project_id
}

module "dashboards" {
  # Depends on module.metric_descriptors to generated those metrics
  depends_on = [module.metric_descriptors]

  source     = "./modules/dashboards"
  aou_env    = var.aou_env
  project_id = var.project_id
}

module "alert_policies" {
  # Depends on module.metric_descriptors to generated those metrics
  depends_on = [module.metric_descriptors]

  source = "./modules/alert_policies"
  project_id = var.project_id
  aou_env    = var.aou_env
  notification_channel_id = var.notification_channel_id
  high_priority_notification_channel_id  = var.high_priority_notification_channel_id
  expected_instance_count  = var.expected_instance_count
  max_response_95p_latency_ms = var.max_response_95p_latency_ms
  max_5xx_error_rate = var.max_5xx_error_rate
  min_buffer_projects_registered = var.min_buffer_projects_registered
  min_buffer_projects_controlled = var.min_buffer_projects_controlled
  max_buffer_errors_per_minute = var.max_buffer_errors_per_minute
}
