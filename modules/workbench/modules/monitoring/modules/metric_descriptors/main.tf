locals {
  # Logging Metric
  logging_metric_descriptor_paths = [for logging_metric_file in fileset("${path.module}/assets/logging_metric_descriptors/", "*.json") : pathexpand(logging_metric_file)]
  logging_metric_descriptor_names = [for logging_metric_path in local.logging_metric_descriptor_paths : replace(basename(logging_metric_path), ".json", "")]

  logging_metric_tuple = [for logging_metric_path in local.logging_metric_descriptor_paths :
  jsondecode(templatefile("${path.module}/assets/logging_metric_descriptors/${logging_metric_path}", {
    project_id = var.project_id
    namespace  = var.aou_env
  }))
  ]
  name_to_logging_metric_descriptor = zipmap(local.logging_metric_descriptor_names, local.logging_metric_tuple)
}

resource "google_logging_metric" "logging_metric" {
  for_each     = local.name_to_logging_metric_descriptor
  name         = each.value.name
  description  = lookup(each.value, "description", null)
  filter       = each.value.filter
  metric_descriptor {
    metric_kind = lookup(each.value.metricDescriptor, "metricKind", null)
    value_type  = lookup(each.value.metricDescriptor, "valueType", null)
    unit        = lookup(each.value.metricDescriptor, "unit", null)

    # Build a list of label objects for each outer iteration
    dynamic "labels" {
      for_each = lookup(each.value.metricDescriptor, "labels", [])
      content {
        key         = labels.value.key
        value_type  = lookup(labels.value, "valueType", null)
        description = lookup(labels.value, "description", null)
      }
    }
    display_name = lookup(each.value.metricDescriptor, "displayName", null)
  }
  value_extractor = lookup(each.value, "valueExtractor", null)
  label_extractors = lookup(each.value, "labelExtractors", null)
  dynamic "bucket_options" {
    for_each = lookup(each.value, "bucketOptions", [])
    content {
      dynamic "linear_buckets" {
        for_each = bucket_options.key == "linearBuckets" ? [bucket_options.value] : []
        content {
          num_finite_buckets = lookup(linear_buckets.value, "numFiniteBuckets", null)
          width  = lookup(linear_buckets.value, "width", null)
          offset = lookup(linear_buckets.value, "offset", null)
        }
      }
      dynamic "exponential_buckets" {
        for_each = bucket_options.key == "exponentialBuckets" ? [bucket_options.value] : []
        content {
          num_finite_buckets = lookup(exponential_buckets.value, "numFiniteBuckets", null)
          growth_factor      = lookup(exponential_buckets.value, "growthFactor", null)
          scale               = lookup(exponential_buckets.value, "scale", null)
        }
      }
      dynamic "explicit_buckets" {
        for_each = bucket_options.key == "explicitBuckets" ? [bucket_options.value] : []
        content {
          bounds = explicit_buckets.bounds
        }
      }
    }
  }
}
