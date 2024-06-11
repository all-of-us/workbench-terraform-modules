# Workbench Terraform Modules
The module directories here represent individually deployable subsystems, 
microservices, or other functional units. It's easy enough to put all buckets, say,
in a `gcs` module, but that wouldn't really let us operate on an individual components-owned bucket.

Following is a broad outline fo each child module. If you feel irritated that you can't see, for example,
all dashboards in one place, you can still go to the Console or use `gcloud`.
## Goals
### Automate ourselves out of a job
All the existing and planned Terraform modules have some level of scripted or otherwise automated
support processes.
## Non-goals
### Become the game in town
We don't want to get into a position where we force anyone to use Terraform if it's not the best
choice for them. Terraform is still pretty new, and changing rapidly. The Google provider is also
under rapid development.  
### Wag the Dog
We do not have any aspirations to absorb any of the tasks that external teams are responsible for,
including building the GCP projects for each of our environments or conducting all administrative
tasks in either pmi-ops or terra projects. If Terraform really "takes off". then it may make sense to
share learnings, and at that point, there may be opportunities for our Terraform stack to use theirs,
or vice versa. While these boundaries may be fuzzy today, hopefully the addition of clear module
inputs and documentation will drive clarification of responsibilities and visibility into state,
dependencies, etc.
### Bypass security approvals
In some cases, actions that require security approval can be performed in Terraform, particularly
around IAM bindings, access groups, and roles. We don't want a situation where an audit finds that
individuals or service accounts were added or modified without going through the proper channels.

One potential workaround here is to invite sysadmin or security personnel to the private repository
to approve changes to the Terraform module inputs.

## Currently Supported Modules

### Reporting
The state for reporting is currently the BigQuery dataset and its tables and views. In the future,
it makes sense to add these sorts of things:
* Reporting-specific metrics
* Notifications on the system
* Reporting-specific logs, specific logs
* Data blocks for views (maybe)

In other words, the primary focus of the module is the Reporting system, but it may be convenient to
add reporting-specific artifacts that might otherwise be concerned with Monitoring or other auxiliary
services.

### Monitoring
We use Terraform to manage metrics descriptor, logs-based Metrics, alert policies, and dashboards. 
To add/edit a new one: you can either add/edit on json files directly or manually setup in GCP console to get json file.
One recommended way can be:
1. Manually create/modify metrics/alerts/dahsboard in test env. 
2. Get the updated json file via google API or gcloud console:
    * [Lists metric descriptors](https://cloud.google.com/monitoring/api/ref_v3/rest/v3/projects.metricDescriptors/list?apix_params=%7B%22name%22%3A%22projects%2Fall-of-us-rw-prod%22%2C%22filter%22%3A%22metric.type%20%3D%20starts_with(%5C%22logging.googleapis.com%2Fuser%5C%22)%22%7D)
    * [Lists dashboards in API Explorer: `gcloud alpha monitoring dashboards list --project all-of-us-rw-prod --format json`
    * Lists logs-based metrics: `gcloud logging metrics list --project all-of-us-rw-prod --format json`
    * Lists alert policies: `gcloud alpha monitoring policies list --project all-of-us-rw-prod --format json`
3. Create/Replace the new json file.
4. Apply this change to other envs.

### Artifact Registry
Google Artifact Registry allows us to provide Docker Hub access to members of the Registered and Controlled Tiers.

### Workload Identity
Workload Identity Federation allows us to grant access to our Service Accounts to external services without using keys
or stored credentials.

These steps allow CircleCI to impersonate an SA for use in deployment:
1. Create a Workflow Identity Pool
2. Create a Workflow Identity Pool Provider
3. Grant access to the deployment Service Account to the Workflow Identity Pool