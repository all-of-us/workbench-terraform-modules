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
  default     = [
    {
      role          = "roles/bigquery.dataOwner"
      special_group = "projectOwners"
    },
    {
      role          = "roles/bigquery.dataViewer"
      special_group = "projectReaders"
    },
    {
      role          = "roles/bigquery.dataEditor"
      special_group = "projectWriters"
    },
    {
      role          = "roles/bigquery.datasets.update"
      special_group = "projectWriters"
    }
  ]
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
  type = string
}

#
# Monitoring
#

variable notification_channel_id {
  description = "The notification channel on where the alert should be delivered to"
  type        = string
}
variable expected_instance_count {
  description = "The expected number of instances. It is used for too_few_instances alert."
  type        = number
  default     = 0
}
