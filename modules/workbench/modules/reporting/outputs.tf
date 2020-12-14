output "schema_paths" {
  description = "Paths to schema files"
  value       = local.table_schema_filenames
}

output "bigquery_dataset" {
  value = module.main.bigquery_dataset
}

output "bigquery_views" {
  value = module.main.bigquery_views
}

output "table_names" {
  value = module.main.table_names
}
