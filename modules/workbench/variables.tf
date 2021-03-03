locals {
  monitoring_project_id = var.monitoring_project_id == null ? var.project_id : var.monitoring_project_id
  high_priority_notification_channel_id = var.high_priority_notification_channel_id == null ? var.notification_channel_id : var.high_priority_notification_channel_id
}

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
      role          = "roles/bigquery.dataOwner"
      special_group = "projectWriters"
    }
  ]
}

#
# Monitoring
#

variable notification_channel_id {
  description = "The notification channel on where the alert should be delivered to"
  type        = string
}
variable high_priority_notification_channel_id {
  description = "The notification channel for more important alerts. We may want to use different notification channel to get quicker response."
  type        = string
  default     = null
}
variable monitoring_project_id {
  description = "GCP Project to create alerts, dashboards and metrics within"
  type        = string
  default     = null
}
variable expected_instance_count {
  description = "The expected number of instances. It is used for too_few_instances alert."
  type        = number
  default     = 0
}
