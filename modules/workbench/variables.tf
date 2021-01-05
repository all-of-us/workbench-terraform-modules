#
# Environment Variables
#
variable aou_env {
  description = "Short name (all lowercase) of All of Us Workbench deployed environments, e.g. local, test, staging, prod."
  type        = string
}

#
# Provider Variables
#

variable project_id {
  description = "GCP Project"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "us-central1-c"
}

#
# Reporting
#
variable reporting_dataset_id {
  description = "BigQuery dataset for workbench reporting data."
  type        = string
}

variable reporting_dataset_access {
  description = "Access list for the reporting dataset"
  type        = list(map(string))
  default     = []
}

# TODO(jaycarlton) codegen this top-level variables as the union
#   of all modules' variables files.
# List of objects whose values correspond to the google_monitoring_notification_channel
# structure
variable "notification_channels" {
  description = "Email address and Friendly Descriptions for Email Notification Channels"
  default = [{
    display_name = "Anonymous  Notification Channel"
    type         = "" # email or
    labels = {
      email = ""
    }
  }]
}
#
# Egress
#

variable sumologic_egress_thresholds {
  description = "Configuration values for egress search content in SumoLogic. The name (key) describes simply the tier name and config: "
  type        = map(map(any))
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
}
