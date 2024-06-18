variable project_id {
  description = "GCP Project"
  type        = string
}

variable aou_env {
  description = "Short name (all lowercase) of All of Us Workbench deployed environments, e.g. local, test, staging, prod."
  type        = string
}

variable "circleci_org_id" {
  type        = string
  description = "Your CircleCI org ID.  Can be found under \"Organization Settings\" in the CircleCI application."
}

variable "circleci_service_account_email" {
  type        = string
  description = "The email address of the service account that CircleCI will impersonate."
  default = null
  nullable = true
}