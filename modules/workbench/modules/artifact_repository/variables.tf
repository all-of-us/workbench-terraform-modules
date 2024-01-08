variable aou_env {
  description = "Short name (all lowercase) of All of Us Workbench deployed environments, e.g. local, test, staging, prod."
  type        = string
}

variable project_id {
  description = "GCP Project"
  type        = string
}

variable registered_tier_group_name {
  description = "Google group that contains all registered tier users"
  type        = string
}

variable controlled_tier_group_name {
  description = "Google group that contains all controlled tier users"
  type        = string
}
