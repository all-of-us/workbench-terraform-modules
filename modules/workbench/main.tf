# Workbench Analytics Reporting Subsystem
module "reporting" {
  source = "./modules/reporting"

  # reporting
  aou_env              = var.aou_env
  reporting_dataset_id = var.reporting_dataset_id

  # provider
  project_id = var.project_id
}

module "egress_detection" {
  source                                  = "./modules/egress_detection"
  aou_env                                 = var.aou_env
  sumologic_egress_thresholds             = var.sumologic_egress_thresholds
  sumologic_parent_folder_id_hexadecimal  = var.aou_env
  sumologic_webhook_id_hexadecimal        = var.aou_env
}
