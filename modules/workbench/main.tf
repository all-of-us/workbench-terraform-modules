# Module for creating an instance of the scratch AoU RW Environment
module "reporting" {
  source = "./modules/reporting"

  # reporting
  aou_env              = var.aou_env
  reporting_dataset_id = var.reporting_dataset_id

  # provider
  project_id = var.project_id
}
