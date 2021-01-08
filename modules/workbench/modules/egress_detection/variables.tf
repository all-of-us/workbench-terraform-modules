variable aou_env {
  description = "Short name (all lowercase) of All of Us Workbench deployed environments, e.g. local, test, staging, prod."
  type        = string
}

variable sumologic_egress_thresholds {
  description = "Configuration values for egress search content in SumoLogic. The name (key) describes simply the tier name and config: "
  type        = map(map(any))
  default = {
    registered_tier_1min_50mib = {
      tier_name   = "registered"
      egress_threshold_mib = 50
      egress_window_sec    = 60
    }
    registered_tier_10min_150mib = {
      tier_name   = "registered"
      egress_threshold_mib = 150
      egress_window_sec    = 600
    }
    registered_tier_1hr_200mib= {
      tier_name   = "registered"
      egress_threshold_mib = 200
      egress_window_sec    = 3600
    }
  }
}

variable sumologic_parent_folder_id_hexadecimal {
  description = "The folder to create alert within, in hexadecimal format"
  type        = string
}

variable sumologic_webhook_id_hexadecimal {
  description = "The webhook ID to notify the alert to, in hexadecimal format"
  type        = string
}
