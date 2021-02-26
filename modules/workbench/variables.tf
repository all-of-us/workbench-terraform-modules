locals {
  monitoring_project_id = var.monitoring_project_id == null ? var.project_id : var.monitoring_project_id
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

variable monitoring_project_id {
  description = "GCP Project to create alerts, dashboards and metrics within"
  type        = string
  default     = null
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
variable expected_instance_count {
  description = "The expected number of instances. It is used for too_few_instances alert."
  type        = number
  default     = 0
}
