variable aou_env {
  description = "Short name (all lowercase) of All of Us Workbench deployed environments, e.g. local, test, staging, prod."
  type        = string
}

variable sumologic_egress_thresholds {
  description = "Configuration values for egress search content in SumoLogic. The name (key) describes simply the tier name and config: "
  type        = map(map(any))
}

variable sumologic_parent_folder_id_hexadecimal {
  description = "The folder to create alert within, in hexadecimal format"
  type        = string
}

variable sumologic_webhook_id_hexadecimal {
  description = "The webhook ID to notify the alert to, in hexadecimal format"
  type        = string
}
