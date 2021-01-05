output "bigquery_dataset" {
  value = module.reporting.bigquery_dataset
}

output "bigquery_views" {
  value = module.reporting.bigquery_views
}

output "table_names" {
  value = module.reporting.table_names
}

output "rendered_queries" {
  value = module.egress_detection.rendered_queries
}

output "encoded_json_queries" {
  description = "JSON-encoded queries"
  value       = module.egress_detection.encoded_json_queries
}

//output "finished_content" {
//  description = "Completed content files sent to SumoLogic API."
//  value       = sumologic_content.main[*]
//}

