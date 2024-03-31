locals {
  range_key                = try(var.data_model.KeyAttributes.SortKey.AttributeName, null)
  read_capacity            = try(var.data_model.ProvisionedCapacitySettings.ProvisionedThroughput.ReadCapacityUnits, null)
  write_capacity           = try(var.data_model.ProvisionedCapacitySettings.ProvisionedThroughput.WriteCapacityUnits, null)
  auto_scaling_read        = try(var.data_model.ProvisionedCapacitySettings.AutoScalingRead, null)
  auto_scaling_write       = try(var.data_model.ProvisionedCapacitySettings.AutoScalingWrite, null)
  global_secondary_indexes = try(var.data_model.GlobalSecondaryIndexes, [])
  splat_table_data         = try(var.data_model.TableData, [])
  splat_table_facet_data   = try(var.data_model.TableFacets[*].TableData[0], [])
  table_data               = concat(local.splat_table_data, local.splat_table_facet_data)
}

resource "aws_dynamodb_table" "DynamoDBTable" {
  dynamic "attribute" {
    for_each = var.data_model.KeyAttributes
    content {
      name = attribute.value.AttributeName
      type = attribute.value.AttributeType
    }
  }
  dynamic "attribute" {
    for_each = { for i in local.global_secondary_indexes : i.IndexName => i.KeyAttributes.PartitionKey }
    iterator = gsi_partition_key
    content {
      name = gsi_partition_key.value.AttributeName
      type = gsi_partition_key.value.AttributeType
    }
  }
  dynamic "attribute" {
    for_each = { for i in local.global_secondary_indexes : i.IndexName => i.KeyAttributes.SortKey if can(i.KeyAttributes.SortKey) }
    iterator = gsi_sort_key
    content {
      name = gsi_sort_key.value.AttributeName
      type = gsi_sort_key.value.AttributeType
    }
  }
  name           = var.name
  hash_key       = var.data_model.KeyAttributes.PartitionKey.AttributeName
  range_key      = local.range_key
  billing_mode   = var.data_model.BillingMode
  read_capacity  = local.read_capacity
  write_capacity = local.write_capacity
  dynamic "global_secondary_index" {
    for_each = { for i in local.global_secondary_indexes : i.IndexName => i }
    content {
      name            = global_secondary_index.value.IndexName
      hash_key        = global_secondary_index.value.KeyAttributes.PartitionKey.AttributeName
      range_key       = try(global_secondary_index.value.KeyAttributes.SortKey.AttributeName, null)
      projection_type = global_secondary_index.value.Projection.ProjectionType
      read_capacity   = try(global_secondary_index.value.ProvisionedCapacitySettings.ProvisionedThroughput.ReadCapacityUnits, null)
      write_capacity  = try(global_secondary_index.value.ProvisionedCapacitySettings.ProvisionedThroughput.WriteCapacityUnits, null)
    }
  }
  dynamic "local_secondary_index" {
    for_each = var.local_secondary_index
    content {
      name               = var.local_secondary_index.name
      non_key_attributes = var.local_secondary_index.non_key_attributes
      projection_type    = var.local_secondary_index.projection_type
      range_key          = var.local_secondary_index.range_key
    }
  }
  dynamic "replica" {
    for_each = var.replica
    content {
      kms_key_arn            = var.replica.kms_key_arn
      point_in_time_recovery = var.replica.point_in_time_recovery
      propagate_tags         = var.replica.propagate_tags
      region_name            = var.replica.region_name
    }
  }
  dynamic "point_in_time_recovery" {
    for_each = var.point_in_time_recovery
    content {
      enabled = var.point_in_time_recovery.enabled
    }
  }
  restore_date_time      = var.restore_date_time
  restore_source_name    = var.restore_source_name
  restore_to_latest_time = var.restore_to_latest_time
  dynamic "server_side_encryption" {
    for_each = var.server_side_encryption
    content {
      enabled     = var.server_side_encryption.enabled
      kms_key_arn = var.server_side_encryption.kms_key_arn
    }
  }
  dynamic "ttl" {
    for_each = var.ttl
    content {
      enabled        = var.ttl.enabled
      attribute_name = var.ttl.attribute_name
    }
  }
  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_view_type
  tags             = var.tags

  lifecycle {
    ignore_changes = [read_capacity, write_capacity]
  }
}

resource "aws_dynamodb_table_item" "DynamoDBItem" {
  for_each   = { for i, j in local.table_data : i => j }
  table_name = aws_dynamodb_table.DynamoDBTable.name
  hash_key   = aws_dynamodb_table.DynamoDBTable.hash_key
  range_key  = lookup(aws_dynamodb_table.DynamoDBTable, "range_key", null)
  item       = jsonencode(each.value)
}

resource "aws_appautoscaling_target" "dynamodb_table_read_target" {
  count              = local.auto_scaling_read == null ? 0 : 1
  max_capacity       = local.auto_scaling_read.ScalableTargetRequest.MaxCapacity
  min_capacity       = local.auto_scaling_read.ScalableTargetRequest.MinCapacity
  resource_id        = "table/${aws_dynamodb_table.DynamoDBTable.name}"
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_table_read_policy" {
  count              = local.auto_scaling_read == null ? 0 : 1
  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.dynamodb_table_read_target[count.index].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dynamodb_table_read_target[count.index].resource_id
  scalable_dimension = aws_appautoscaling_target.dynamodb_table_read_target[count.index].scalable_dimension
  service_namespace  = aws_appautoscaling_target.dynamodb_table_read_target[count.index].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    target_value = local.auto_scaling_read.ScalingPolicyConfiguration.TargetValue
  }
}

resource "aws_appautoscaling_target" "dynamodb_table_write_target" {
  count              = local.auto_scaling_write == null ? 0 : 1
  max_capacity       = local.auto_scaling_write.ScalableTargetRequest.MaxCapacity
  min_capacity       = local.auto_scaling_write.ScalableTargetRequest.MinCapacity
  resource_id        = "table/${aws_dynamodb_table.DynamoDBTable.name}"
  scalable_dimension = "dynamodb:table:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_table_write_policy" {
  count              = local.auto_scaling_write == null ? 0 : 1
  name               = "DynamoDBWriteCapacityUtilization:${aws_appautoscaling_target.dynamodb_table_write_target[count.index].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dynamodb_table_write_target[count.index].resource_id
  scalable_dimension = aws_appautoscaling_target.dynamodb_table_write_target[count.index].scalable_dimension
  service_namespace  = aws_appautoscaling_target.dynamodb_table_write_target[count.index].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }

    target_value = local.auto_scaling_write.ScalingPolicyConfiguration.TargetValue
  }
}
