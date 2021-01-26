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

  logging_metric_tuple = [for logging_metric_path in local.monitoring_metric_descriptor_paths :
  jsondecode(templatefile("${path.module}/assets/logging_metric_descriptors/${logging_metric_path}", {
    project_id = var.project_id
    namespace  = var.aou_env
  }))
  ]
  name_to_logging_metric_descriptor = zipmap(local.logging_metric_descriptor_names, local.logging_metric_tuple)
}

resource "google_monitoring_metric_descriptor" "metric_descriptor" {
  for_each = local.name_to_monitoring_metric_descriptor

  description  = each.value.description
  display_name = each.value.displayName
  metric_kind  = each.value.metricKind
  launch_stage = lookup(each.value, "launch_stage", "LAUNCH_STAGE_UNSPECIFIED")
  project      = var.project_id
  type         = each.value.type
  unit         = each.value.unit
  value_type   = each.value.valueType

  # Build a list of label objects for each outer iteration
  dynamic "labels" {
    for_each = each.value.labels
    content {
      key         = lookup(labels.value, "key", null)
      value_type  = lookup(labels.value, "value_type", null)
      description = lookup(labels.value, "description", null)
    }
  }
  dynamic "metadata" {
    for_each = each.value.metadata
    content {
      sample_period = lookup(metadata.value, "sample_period", null)
      ingest_delay = lookup(metadata.value, "ingest_delay", null)
    }
  }
}

resource "google_logging_metric" "logging_metric" {
  for_each = local.name_to_logging_metric_descriptor
  name   = each.value.name
  description  = each.value.description
  filter = each.value.filter
  metric_descriptor {
    metric_kind = each.value.metric_descriptor.metric_kind
    value_type  = each.value.metric_descriptor.value_type
    unit        = each.value.metric_descriptor.unit
    # Build a list of label objects for each outer iteration
    dynamic "labels" {
      for_each = each.value.metric_descriptor.labels
      content {
        key         = lookup(labels.value, "key", null)
        value_type  = lookup(labels.value, "value_type", null)
        description = lookup(labels.value, "description", null)
      }
    }
    display_name = each.value.metric_descriptor.display_name
  }
  value_extractor = each.value.value_extractor
  label_extractors = {
    "mass" = each.value.label_extractors.mass
    "sku"  = each.value.label_extractors.sku
  }
  dynamic "bucket_options" {
    for_each = each.value.bucket_options
    content {
      dynamic "linear_buckets" {
        for_each = bucket_options.value.linear_buckets
        content {
          num_finite_buckets = linear_buckets.value.num_finite_buckets
          width              = linear_buckets.value.width
          offset             = linear_buckets.value.offset
        }
      }
      dynamic "exponentialBuckets" {
        for_each = bucket_options.value.exponentialBuckets
        content {
          numFiniteBuckets    = exponentialBuckets.value.numFiniteBuckets
          growthFactor        = exponentialBuckets.value.growthFactor
          scale               = exponentialBuckets.value.offset
        }
      }
    }
  }
}
