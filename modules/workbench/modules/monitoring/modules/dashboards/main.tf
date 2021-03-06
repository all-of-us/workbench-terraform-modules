locals {
  dashboard_files = fileset("${path.module}/assets/dashboards_json", "*.json")
  # String indices for dashboard resource set
  dashboard_names = [for path in local.dashboard_files : replace(basename(path), ".json", "")]

  # Actual JSON strings for each dashboard.
  dashboards = [for full_path in local.dashboard_files :
    templatefile(pathexpand("${path.module}/assets/dashboards_json/${full_path}"), {
      namespace                           = var.aou_env
      project_id                          = var.project_id
      metric__labels__access_tier_short_name  = join("", ["$", "{metric.labels.access_tier_short_name}"])
      metric__labels__access_tier_short_names = join("", ["$", "{metric.labels.access_tier_short_names}"])
      metric__labels__active_status           = join("", ["$", "{metric.labels.ActiveStatus}"])
      metric__labels__buffer_entry_status     = join("", ["$", "{metric.labels.BufferEntryStatus}"])
      metric__labels__data_access_level       = join("", ["$", "{metric.labels.DataAccessLevel}"])
      metric__labels__gsuite_domain           = join("", ["$", "{metric.labels.gsuite_domain}"])
      metric__labels__name                    = join("", ["$", "{metric.labels.name}"])
      metric__labels__requestId               = join("", ["$", "{metric.labels.requestId}"])
      metric__labels__status                  = join("", ["$", "{metric.labels.status}"])
    })
  ]

  # Build a map for use with for_each below
  name_to_dashboard = zipmap(local.dashboard_names, local.dashboards)
}

resource "google_monitoring_dashboard" "dashboard" {
  for_each       = local.name_to_dashboard
  dashboard_json = each.value
}

