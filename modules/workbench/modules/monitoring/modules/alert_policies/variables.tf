variable project_id {
  description = "GCP Project"
  type        = string
}

variable aou_env {
  description = "Short name (all lowercase) of All of Us Workbench deployed environments, e.g. local, test, staging, prod."
  type        = string
}

variable notification_channel_id {
  description = "The notification channel on where the alert should be delivered to"
  type        = string
}

variable high_priority_notification_channel_id {
  description = "The notification channel for more important alerts. "
  type        = string
}

variable expected_instance_count {
  description = "The expected number of instances. It is used for too_few_instances alert."
  type        = number
}

variable max_response_95p_latency_ms {
  description = "Alert if we see our API 95 percentile latency exceed this"
  type        = number
}

variable max_5xx_error_rate {
  description = "Alert if we see our API returns 5XX errors above this rate for a duration"
  type        = number
}

variable min_buffer_projects_registered {
  description = "Alert if we have fewer than this many projects in the registered tier buffer"
  type        = number
}

variable min_buffer_projects_controlled {
  description = "Alert if we have fewer than this many projects in the controlled tier buffer"
  type        = number
}

variable max_buffer_errors_per_minute {
  description = "Alert if we see billing project buffer errors above this rate"
  type        = number
}

