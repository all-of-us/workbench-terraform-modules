variable aou_env {
  description = "Short name (all lowercase) of All of Us Workbench deployed environments, e.g. local, test, staging, prod."
  type        = string
}

variable project_id {
  description = "GCP Project"
  type        = string
}

variable reporting_dataset_id {
  description = "BigQuery dataset for workbench reporting data."
  type        = string
}

variable reporting_dataset_access {
  description = "Access list for the reporting dataset"
  type        = list(map(string))
  default     = null
}
