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
  expected_instance_count = var.expected_instance_count
  monitoring_enabled = var.monitoring_enabled
}
