locals {
  policy_dir   = "${path.module}/assets/alert_policies"
  policy_paths = [for policy_file in fileset("${local.policy_dir}/", "*.json") : pathexpand(policy_file)]
  policy_names = [for policy_path in local.policy_paths : replace(basename(policy_path), ".json", "")]

  policy_tuple = [for policy_path in local.policy_paths :
  jsondecode(templatefile("${local.policy_dir}/${policy_path}", {
    project_id = var.project_id
    namespace  = var.aou_env
    notification_channel_id  = var.notification_channel_id
  }))
  ]
  # The map-valued for-expression syntax is flaky. A workaround is to make a list of keys and 0
  # a list of values and just zip them. https://github.com/hashicorp/terraform/issues/20230#issuecomment-461783910
  name_to_alert_policy = zipmap(local.policy_names, local.policy_tuple)
}

resource "google_monitoring_alert_policy" "policy" {
  for_each = local.name_to_alert_policy

  combiner     = each.value.combiner
  display_name = each.value.displayName

  dynamic "conditions" {
    for_each = each.value.conditions
    content {
      display_name = lookup(conditions.value, "displayName")
      condition_absent {
        duration = lookup(conditions.value.conditionAbsent, "duration")
        filter   = lookup(conditions.value.conditionAbsent, "filter")
        trigger {
          percent = lookup(lookup(conditions.value.conditionAbsent, "trigger"), "percent")
        }

        dynamic "aggregations" {
          for_each = lookup(conditions.value.conditionAbsent, "aggregations")
          content {
            alignment_period     = lookup(aggregations.value, "alignmentPeriod")
            per_series_aligner     = lookup(aggregations.value, "perSeriesAligner")
            cross_series_reducer     = lookup(aggregations.value, "crossSeriesReducer")
          }
        }
      }
    }
  }
}

