// See https://www.terraform.io/docs/configuration/providers.html
// Child modules receive their provider configurations from the root module.
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

# To workaround import issue
# `The configuration for module.workbench.provider["registry.terraform.io/hashicorp/google"] depends on
# values that cannot be determined until apply.`
# " https://github.com/hashicorp/terraform/issues/26211#issuecomment-705084351
# Uncomment to replace provider block when performing terraform import.
//provider "google" {
//  version = "3.5.0"
//  project = "all-of-us-workbench-test"
//  region  = "us-central1"
//  zone    = "us-central1-c"
//}

provider "google" {
  version = "3.5.0"
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

