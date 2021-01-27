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
To add a new one: 
* Reporting-specific metrics
* Notifications on the system
* Reporting-specific logs, specific logs
* Data blocks for views (maybe)

In other words, the primary focus of the module is the Reporting system, but it may be convenient to
add reporting-specific artifacts that might otherwise be concerned with Monitoring or other auxiliary
services.