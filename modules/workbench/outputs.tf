output "bigquery_dataset" {
  value = module.reporting.bigquery_dataset
}

output "bigquery_views" {
  value = module.reporting.bigquery_views
}

output "table_names" {
  value = module.reporting.table_names
}

output "docker_repo_name" {
  description = "Remote docker GAR repo name"
  value       = module.artifact_registry.docker_repo_name
}

