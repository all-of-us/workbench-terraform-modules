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
  }
}

# To workaround import issue
# `The configuration for module.workbench.provider["registry.terraform.io/hashicorp/google"] depends on
# values that cannot be determined until apply.`
# " https://github.com/hashicorp/terraform/issues/26211#issuecomment-705084351
# Uncomment to replace provider block when performing terraform import.
provider "google" {
  version = "3.5.0"
  project = "all-of-us-workbench-test"
  region  = "us-central1"
  zone    = "us-central1-c"
}

# Define sensitive keys as env vars. All three must be absent from the provider block
# and exported for this to work.
# TODO(RW-6103): Integrate with Vault and let Terraform pull those secret from Vault.
# $ export SUMOLOGIC_ACCESSID="your-access-id"
# $ export SUMOLOGIC_ACCESSKEY="your-access-key"
# $ export SUMOLOGIC_ENVIRONMENT=us2
provider "sumologic" {}
