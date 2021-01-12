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
variable tiers {
  description = "List of tiers"
  type        = list(string)
  default     = ["registered"]
}

variable sumologic_egress_thresholds {
  description = "Configuration values for egress search content in SumoLogic. The name (key) describes simply the tier name and config: "
  type        = map(map(any))
  default = {
    registered_tier_1min_50mib = {
      tier_name   = "registered"
      egress_threshold_mib = 50
      egress_window_sec    = 60
      cron_expression      = "0 * * * * ? *"
      time_range           = "-5m"
      schedule_type        = "RealTime"
    }
    registered_tier_10min_150mib = {
      tier_name   = "registered"
      egress_threshold_mib = 150
      egress_window_sec    = 600
      cron_expression      = "0 * * * * ? *"
      time_range           = "-5m"
      schedule_type        = "RealTime"
    }
    registered_tier_1hr_200mib= {
      tier_name   = "registered"
      egress_threshold_mib = 200
      egress_window_sec    = 3600
      cron_expression      = "0 0 * * * ? *"
      time_range           = "-12m"
      schedule_type        = "1Hour"
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
