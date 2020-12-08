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
  description = "Access grants to the dataset"
  type        = list(map(string)) # It's not possible to use optional attributes, so this is the tightest type
  default     = []
}
#
# Egress
#
  type        = list(map(string)) # It's not possible to use optional attributes, so this is the tightest type
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
