output "rendered_queries" {
  description = "Queries for each egress rule, in human-readable form"
  value = [for egress_rule in keys(var.sumologic_egress_thresholds) :
    local.queries_rendered
  ]
}

output "encoded_json_queries" {
  description = "JSON-encoded queries"
  value       = local.queries_encoded[*]
}

output "finished_content" {
  description = "Completed content files sent to SumoLogic API."
  value       = sumologic_content.main[*]
}

