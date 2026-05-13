variable aou_env {
  description = "Short name (all lowercase) of All of Us Workbench deployed environments, e.g. local, test, staging, prod."
  type        = string
}

variable project_id {
  description = "GCP Project"
  type        = string
}

variable reader_group_names {
  description = "Google groups that should have read access to the artifact registry"
  type        = list(string)
}
