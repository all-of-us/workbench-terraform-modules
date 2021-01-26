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
  enabled      = each.value.enabled

  documentation {
    content     =  lookup(each.value.documentation, "content")
    mime_type   =  lookup(each.value.documentation, "mimeType")
  }

  dynamic "conditions" {
    for_each = each.value.conditions
    content {
      display_name = lookup(conditions.value, "displayName")
      dynamic "condition_absent" {
        for_each = conditions.value == "conditionAbsent" ? [conditions.value] : []
        content {
          duration = lookup(condition_absent.value, "duration")
          filter   = lookup(condition_absent.value, "filter")
          trigger {
            percent = lookup(lookup(condition_absent.value, "trigger"), "percent")
            count   = lookup(lookup(condition_absent.value, "trigger"), "count")
          }

          dynamic "aggregations" {
            for_each = lookup(condition_absent.value, "aggregations")
            content {
              alignment_period       = lookup(aggregations.value, "alignmentPeriod")
              per_series_aligner     = lookup(aggregations.value, "perSeriesAligner")
              cross_series_reducer   = lookup(aggregations.value, "crossSeriesReducer")
            }
          }
        }
      }
      dynamic "condition_threshold" {
        for_each = conditions.value == "conditionThreshold" ? [conditions.value] : []
        content {
          duration = lookup(condition_threshold.value, "duration")
          filter   = lookup(condition_threshold.value, "filter")
          comparison   = lookup(condition_threshold.value, "comparison")
          threshold_value   = lookup(condition_threshold.value, "thresholdValue")
          trigger {
            percent = lookup(lookup(condition_threshold.value, "trigger"), "percent")
            count = lookup(lookup(condition_threshold.value, "trigger"), "count")
          }

          dynamic "aggregations" {
            for_each = lookup(condition_threshold.value, "aggregations")
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
}
