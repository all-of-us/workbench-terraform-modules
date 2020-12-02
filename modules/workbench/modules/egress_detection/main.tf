data "sumologic_personal_folder" "aou_rw_egress_alerts" {}

locals {
  content_dir           = pathexpand("${path.module}/assets/content")
  search_configs        = fileset(local.content_dir, "*.json")
  content_template_path = pathexpand("${local.content_dir}/egress_window_template.json")
}

# Simply export a content file or folder and put the JSON file in ./assets/content
resource "sumologic_content" "main" {
  for_each  = var.sumologic_egress_thresholds
  parent_id = data.sumologic_personal_folder.aou_rw_egress_alerts.id
  config = templatefile(local.content_template_path, {
    aou_env              = var.aou_env
    egress_threshold_mib = lookup(each.value, "egress_threshold_mib", 0)
    egress_window_sec    = lookup(each.value, "egress_window_sec", 0)
  })
}
