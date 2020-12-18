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
