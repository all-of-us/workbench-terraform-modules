// See https://www.terraform.io/docs/configuration/providers.html
// Child modules receive their provider configurations from the root module.
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    sumologic = {
      source = "terraform-providers/sumologic"
    }
  }
}

provider "google" {
  version = "3.5.0"
  project = var.project_id
  region  = var.region
  zone    = var.zone
  # Rather than provide a credentials_file value, we should
  # use Application-default credentials.
  # https://cloud.google.com/sdk/gcloud/reference/auth/application-default/login
}

# Define SUMOLOGIC_ACCESSID and SUMOLOGIC_ACCESSKEY env vars
provider "sumologic" {
  access_id   = "sukzQ4XDP8XBDA"
  access_key  = "0pKae4xvF4QlULDWLzW6J1g4xKkrD7IBbOVRUYO8WZuoLyRAzykZyUv4b7RwYwfM"
  environment = "us2"
}
