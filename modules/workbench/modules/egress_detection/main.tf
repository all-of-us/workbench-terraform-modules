data "sumologic_personal_folder" "aou_rw_egress_alerts" {}

locals {
  content_dir           = pathexpand("${path.module}/assets/content")
  search_configs        = fileset(local.content_dir, "*.json")
  content_template_path = pathexpand("${local.content_dir}/egress_window_template.json")
  query_path            = pathexpand("${local.content_dir}/query.txt")
}

# Nested calls to templatefile() aren't possible, so maybe doing a template data block
# for the inner query file will work. https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file
data "template_file" "query_text" {
  for_each = var.sumologic_egress_thresholds
  template = file(local.query_path)
  vars = {
    aou_env              = var.aou_env
    egress_threshold_mib = lookup(each.value, "egress_threshold_mib", 0)
    egress_window_sec    = lookup(each.value, "egress_window_sec", 0)
  }
}

# Simply export a content file or folder and put the JSON file in ./assets/content.
# Since the query is so long (and critical) and is json-encoded, it's easier
# to configure it separately.
resource "sumologic_content" "main" {
  for_each  = var.sumologic_egress_thresholds
  parent_id = data.sumologic_personal_folder.aou_rw_egress_alerts.id
  config = templatefile(local.content_template_path, {
    aou_env              = var.aou_env
    egress_threshold_mib = lookup(each.value, "egress_threshold_mib", 0)
    egress_window_sec    = lookup(each.value, "egress_window_sec", 0)

    query_text = "${jsonencode(data.template_file.query_text[each.key].rendered)}"
  })
}
