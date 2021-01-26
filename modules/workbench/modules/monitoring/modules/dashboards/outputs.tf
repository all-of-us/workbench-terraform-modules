output "dashboard_id_to_json" {
  description = "The generated dashboard id to dashboard json file"

  value       = {
  for dashboard in google_monitoring_dashboard.dashboard:
  dashboard.id => dashboard.dashboard_json
  }
}
