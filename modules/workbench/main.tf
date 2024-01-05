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
  aou_env = var.aou_env
  notification_channel_id = var.notification_channel_id
  high_priority_notification_channel_id = local.high_priority_notification_channel_id
  alert_thresholds = var.alert_thresholds
}

# GAR Repository
module "repository" {
  source = "./modules/repository"
  project_id = var.project_id
  aou_env = var.aou_env
  registered_tier_group_name = var.registered_tier_group_name
  controlled_tier_group_name = var.controlled_tier_group_name
}
