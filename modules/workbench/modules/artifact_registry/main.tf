# Remote docker gar repo
resource "google_artifact_registry_repository" "gar_remote_docker" {
  project = var.project_id
  location      = "us-central1"
  repository_id = join("-", ["aou-rw-gar-remote-repo-docker", var.aou_env])
  description   = "Workbench remote docker repository"
  format        = "DOCKER"
  mode          = "REMOTE_REPOSITORY"
  remote_repository_config {
    description = "docker hub"
    docker_repository {
      public_repository = "DOCKER_HUB"
    }
  }
  cleanup_policies {
    action = "DELETE"
    id = "delete-older-than-30-days"

    condition {
      older_than = "2592000s"
      package_name_prefixes = []
      tag_prefixes = []
      tag_state = "ANY"
      version_name_prefixes = []
    }
  }
}

resource "google_artifact_registry_repository_iam_member" "remote_docker_iam-member_rt" {
  project = google_artifact_registry_repository.gar_remote_docker.project
  location = google_artifact_registry_repository.gar_remote_docker.location
  repository = google_artifact_registry_repository.gar_remote_docker.name
  role = "roles/artifactregistry.reader"
  member = join("", ["group:", var.registered_tier_group_name])
}

resource "google_artifact_registry_repository_iam_member" "remote_docker_iam-member_ct" {
  project = google_artifact_registry_repository.gar_remote_docker.project
  location = google_artifact_registry_repository.gar_remote_docker.location
  repository = google_artifact_registry_repository.gar_remote_docker.name
  role = "roles/artifactregistry.reader"
  member = join("", ["group:", var.controlled_tier_group_name])
}
