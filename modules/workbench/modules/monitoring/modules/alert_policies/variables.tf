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

variable alert_thresholds {
  description = "Alerting thresholds"
  type = object({
    min_instance_count = number
    max_5xx_error_rate = number
    min_buffer_projects_registered = number
    min_buffer_projects_controlled = number
    max_buffer_errors_per_minute = number
  })
}
