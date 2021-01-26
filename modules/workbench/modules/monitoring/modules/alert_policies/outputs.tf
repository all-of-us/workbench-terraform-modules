output "policy_id_to_name" {
  description = "The generated policy id to policy name map"

  value       = {
    for policy in google_monitoring_alert_policy.policy:
    policy.id => policy.name
  }
}
