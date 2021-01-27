// See https://www.terraform.io/docs/configuration/providers.html
// Child modules receive their provider configurations from the root module.
terraform {
  required_providers {
    google = ">= 3.23.0"
    sumologic = {
      source = "terraform-providers/sumologic"
    }
  }
}

//provider "google" {
//  version = "3.53.0"
//  project = local.project_id
//  region  = local.region
//  zone    = local.zone
//}
//
//provider "google" {
//  version = "3.5.0"
//  project = var.project_id
//  region  = var.region
//  zone    = var.zone
//}

# Define sensitive keys as env vars. All three must be absent from the provider block
# and exported for this to work.
# TODO(RW-6103): Integrate with Vault and let Terraform pull those secret from Vault.
# $ export SUMOLOGIC_ACCESSID="your-access-id"
# $ export SUMOLOGIC_ACCESSKEY="your-access-key"
# $ export SUMOLOGIC_ENVIRONMENT=us2
provider "sumologic" {}
