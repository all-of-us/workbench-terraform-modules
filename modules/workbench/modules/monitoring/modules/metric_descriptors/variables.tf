variable project_id {
  description = "GCP Project"
  type        = string
}

variable aou_env {
  description = "Short name (all lowercase) of All of Us Workbench deployed environments, e.g. local, test, staging, prod."
  type        = string
}

variable "monitoring_enabled" {
  type        = bool
  description = "Enable flag for this module. If set to false, no resources will be created."
  default     = true
}