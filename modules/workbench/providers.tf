// See https://www.terraform.io/docs/configuration/providers.html
// Child modules receive their provider configurations from the root module.
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    sumologic = {
      source  = "SumoLogic/sumologic"
      version = "2.6.0"
    }
    //    sumologic = {
    //      source = "terraform-providers/sumologic" // "SumoLogic/sumologic" ?
    //    }
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

# Define sensitive keys as env vars. All three must be absent from the provider block
# and exported for this to work.
# $ export SUMOLOGIC_ACCESSID="your-access-id"
# $ export SUMOLOGIC_ACCESSKEY="your-access-key"
# $ export SUMOLOGIC_ENVIRONMENT=us2
provider "sumologic" {}
