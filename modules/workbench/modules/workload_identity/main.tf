# adapted from https://github.com/jtreutel/circleci-gcp-oidc-terraform/blob/master/main.tf

resource "google_iam_workload_identity_pool" "circleci" {
  project = var.project_id
  workload_identity_pool_id = "${var.aou_env}-oidc-pool"
  display_name              = "${var.aou_env} OIDC Auth Pool"
  description               = "Identity pool for CircleCI OIDC authentication - ${var.aou_env}"
}

resource "google_iam_workload_identity_pool_provider" "circleci" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.circleci.workload_identity_pool_id
  workload_identity_pool_provider_id = "${var.aou_env}-oidc-prv"
  display_name                       = "${var.aou_env} OIDC Auth"
  description                        = "Identity pool provider for CircleCI OIDC authentication - ${var.aou_env}"
  attribute_condition                = "attribute.org_id=='${var.circleci_org_id}'"
  attribute_mapping = {
    "attribute.org_id" = "assertion.aud",
    "google.subject"   = "assertion.sub"
  }
  oidc {
    allowed_audiences = [var.circleci_org_id]
    issuer_uri        = "https://oidc.circleci.com/org/${var.circleci_org_id}"
  }
}

# allows retrieval of the google project number
data "google_project" "project" {
  project_id = var.project_id
}

# allows retrieval of the service account's full path, as its "name"
data "google_service_account" "circleci_service_account" {
  account_id = var.circleci_service_account_email
}

resource "google_service_account_iam_member" "circleci_impersonation" {
  service_account_id = data.google_service_account.circleci_service_account.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.circleci.workload_identity_pool_id}/attribute.org_id/${var.circleci_org_id}"
}
