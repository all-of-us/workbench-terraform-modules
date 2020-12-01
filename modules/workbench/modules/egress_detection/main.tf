data "sumologic_folder" "aou_rw_egress_alerts" {}

locals {
  search_dir     = "${path.module}/assets/searches"
  search_configs = fileset(local.search_dir, "*.json")
  users_dir      = "${path.module}/assets/searches"
}

# Pass in user details, as they are not public
resource "sumologic_user" "main" {
  for_each    = var.users
  first_name  = lookup(each.value, "first_name")
  last_name   = lookup(each.value, "last_name")
  email       = lookup(each.value, "email")
  role_ids    = lookup(each.value, "role_ids", [])
  transfer_to = lookup(each.value, "transfer_to")
}


resource "sumologic_content" "main" {
  for_each = local.search_configs

  parent_id = data.sumologic_folder.aou_rw_egress_alerts.id
  config    = jsonencode(templatefile(each.value, {}))
}
