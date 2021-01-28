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

variable expected_instance_count {
  description = "The expected number of instances. It is used for too_few_instances alert."
  type        = number
}
