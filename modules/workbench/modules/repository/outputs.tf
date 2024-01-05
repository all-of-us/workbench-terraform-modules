output "docker_repo_name" {
  description = "Remote docker GAR repo name"
  value       = google_artifact_registry_repository.gar_remote_docker.name
}
