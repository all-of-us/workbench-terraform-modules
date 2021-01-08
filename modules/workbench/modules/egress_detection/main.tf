locals {
  content_dir           = pathexpand("${path.module}/assets/content")
  search_configs        = fileset(local.content_dir, "*.json")
  content_template_path = pathexpand("${local.content_dir}/egress_window_template.json")
  query_path            = pathexpand("${local.content_dir}/query.txt")

  queries_rendered = { for egress_rule, threshold in var.sumologic_egress_thresholds :
    tostring(egress_rule) => templatefile(local.query_path, {
      aou_env              = var.aou_env
      tier_name            = lookup(threshold, "tier_name", 0)
      egress_threshold_mib = lookup(threshold, "egress_threshold_mib", 0)
      egress_window_sec    = lookup(threshold, "egress_window_sec", 0)
    })
  }

  queries_encoded = { for egress_rule, query_text in local.queries_rendered :
    egress_rule => jsonencode(query_text)
  }

  # Build a map of rendered Content templates for use in the sumologic_content resource and
  # module outputs
  egress_rule_to_config = { for egress_rule, threshold in var.sumologic_egress_thresholds :
  egress_rule => templatefile(local.content_template_path, {
    aou_env              = var.aou_env
    webhook_id           = var.sumologic_webhook_id_hexadecimal
    tier_name            = lookup(threshold, "tier_name", 0)
    egress_threshold_mib = lookup(threshold, "egress_threshold_mib", 0)
    egress_window_sec    = lookup(threshold, "egress_window_sec", 0)
    query_text           = lookup(local.queries_encoded, egress_rule)
  })
  }
}

# Simply export a content file or folder and put the JSON file in ./assets/content.
# Since the query is so long (and critical) and is json-encoded, it's easier
# to configure it separately.
resource "sumologic_content" "main" {
  for_each  = var.sumologic_egress_thresholds
  parent_id = var.sumologic_parent_folder_id_hexadecimal
  config    = lookup(local.egress_rule_to_config, each.key, "")
}

