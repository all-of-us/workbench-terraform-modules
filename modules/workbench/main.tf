# Workbench Analytics Reporting Subsystem
module "reporting" {
  source = "./modules/reporting"

  # reporting
  aou_env              = var.aou_env
  reporting_dataset_id = var.reporting_dataset_id
  reporting_dataset_access = var.reporting_dataset_access

  # provider
  project_id = var.project_id
}

# GCP Monitoring
module "monitoring" {
  count = var.monitoring_enabled ? 1 : 0

  source = "./modules/monitoring"
  project_id = var.project_id
  notification_channel_id = var.notification_channel_id
  expected_instance_count = var.expected_instance_count
  aou_env = var.aou_env
}
