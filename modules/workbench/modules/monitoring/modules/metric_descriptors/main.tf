locals {
  # Monitoring Metric
  monitoring_metric_descriptor_paths = [for metric_file in fileset("${path.module}/assets/monitoring_metric_descriptors/", "*.json") : pathexpand(metric_file)]
  monitoring_metric_descriptor_names = [for metric_path in local.monitoring_metric_descriptor_paths : replace(basename(metric_path), ".json", "")]

  metric_tuple = [for metric_path in local.monitoring_metric_descriptor_paths :
  jsondecode(templatefile("${path.module}/assets/monitoring_metric_descriptors/${metric_path}", {
    project_id = var.project_id
    namespace  = var.aou_env
  }))
  ]
  # The map-valued for-expression syntax is flaky. A workaround is to make a list of keys and 0
  # a list of values and just zip them. https://github.com/hashicorp/terraform/issues/20230#issuecomment-461783910
  name_to_monitoring_metric_descriptor = zipmap(local.monitoring_metric_descriptor_names, local.metric_tuple)

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

resource "google_monitoring_metric_descriptor" "metric_descriptor" {
  for_each = var.monitoring_enabled ? local.name_to_monitoring_metric_descriptor : null

  description  = each.value.description
  display_name = each.value.displayName
  metric_kind  = each.value.metricKind
  launch_stage = lookup(each.value, "launchStage", null)
  project      = var.project_id
  type         = each.value.type
  unit         = each.value.unit
  value_type   = each.value.valueType

  # Build a list of label objects for each outer iteration
  dynamic "labels" {
    for_each = each.value.labels
    content {
      key         = lookup(labels.value, "key", null)
      value_type  = lookup(labels.value, "valueType", null)
      description = lookup(labels.value, "description", null)
    }
  }
  dynamic "metadata" {
    for_each = lookup(each.value, "metadata", [])
    content {
      sample_period = lookup(metadata.value, "samplePeriod", null)
      ingest_delay  = lookup(metadata.value, "ingestDelay", null)
    }
  }
}

resource "google_logging_metric" "logging_metric" {
  for_each = var.monitoring_enabled ? local.name_to_logging_metric_descriptor : null
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
