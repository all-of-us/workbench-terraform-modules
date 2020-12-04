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
