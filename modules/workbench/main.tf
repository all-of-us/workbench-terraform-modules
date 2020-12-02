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
  source                      = "./modules/egress_detection"
  sumologic_egress_thresholds = var.sumologic_egress_thresholds
  aou_env                     = var.aou_env
}
