output "egress_alert_rendered_queries" {
  description = "Queries for each egress rule, in human-readable form"
  value = [for egress_rule in keys(var.sumologic_egress_thresholds) :
    local.queries_rendered
  ]
}
