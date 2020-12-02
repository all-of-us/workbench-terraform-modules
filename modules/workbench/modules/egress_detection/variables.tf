variable aou_env {
  description = "Short name (all lowercase) of All of Us Workbench deployed environments, e.g. local, test, staging, prod."
  type        = string
}

variable sumologic_egress_thresholds {
  description = "Configuration values for egress search content in SumoLogic. The name (key) describes simply the tier name and config: "
  default = {
    tier_1__short = {
      vpc_perimeter_name   = "tier-name-1"
      egress_threshold_mib = 1
      egress_window_sec    = 60
    }
    tier_1__med = {
      vpc_perimeter_name   = "tier-name-1"
      egress_threshold_mib = 1000000
      egress_window_sec    = 120
    }
    tier_1__large = {
      vpc_perimeter_name   = "tier-name-1"
      egress_threshold_mib = 1000000
      egress_window_sec    = 1800
    }
    tier_2__short = {
      vpc_perimeter_name   = "tier-name-2"
      egress_threshold_mib = 1
      egress_window_sec    = 60
    }
    tier_2__med = {
      vpc_perimeter_name   = "tier-name-2"
      egress_threshold_mib = 1000000
      egress_window_sec    = 120
    }
    tier_2__large = {
      vpc_perimeter_name   = "tier-name-2"
      egress_threshold_mib = 1000000
      egress_window_sec    = 1800
    }

  }

  type = map(any)
}
