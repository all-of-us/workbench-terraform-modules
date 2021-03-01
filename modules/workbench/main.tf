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
  source = "./modules/monitoring"
  project_id = local.monitoring_project_id
  notification_channel_id = var.notification_channel_id
  high_priority_notification_channel_id = local.high_priority_notification_channel_id
  expected_instance_count = var.expected_instance_count
  aou_env = var.aou_env
}
