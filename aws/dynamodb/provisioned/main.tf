resource "aws_dynamodb_table" "main" {
  name           = var.name
  billing_mode   = "PROVISIONED"
  read_capacity  = var.capacity.min_read_unit
  write_capacity = var.capacity.min_write_unit

  hash_key = var.partition_key.name
  attribute {
    name = var.partition_key.name
    type = var.partition_key.type
  }

  range_key = var.sort_key.name
  dynamic "attribute" {
    for_each = var.sort_key.name != null ? [1] : []
    content {
      name = var.sort_key.name
      type = var.sort_key.type
    }
  }

  lifecycle {
    ignore_changes = [read_capacity, write_capacity]
  }
}

# resource "aws_appautoscaling_target" "dynamodb_table_read" {
#   min_capacity       = var.capacity.min_read_unit
#   max_capacity       = var.capacity.max_read_unit
#   resource_id        = "table/${aws_dynamodb_table.main.name}"
#   scalable_dimension = "dynamodb:table:ReadCapacityUnits"
#   service_namespace  = "dynamodb"
# }

# resource "aws_appautoscaling_policy" "dynamodb_table_read_policy" {
#   name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.dynamodb_table_read.resource_id}"
#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.dynamodb_table_read.resource_id
#   scalable_dimension = aws_appautoscaling_target.dynamodb_table_read.scalable_dimension
#   service_namespace  = aws_appautoscaling_target.dynamodb_table_read.service_namespace

#   target_tracking_scaling_policy_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "DynamoDBReadCapacityUtilization"
#     }

#     target_value = 70
#   }
# }

# resource "aws_appautoscaling_target" "dynamodb_table_write" {
#   min_capacity       = var.capacity.min_write_unit
#   max_capacity       = var.capacity.max_write_unit
#   resource_id        = "table/${aws_dynamodb_table.main.name}"
#   scalable_dimension = "dynamodb:table:WriteCapacityUnits"
#   service_namespace  = "dynamodb"
# }

# resource "aws_appautoscaling_policy" "dynamodb_table_write_policy" {
#   name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.dynamodb_table_write.resource_id}"
#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.dynamodb_table_write.resource_id
#   scalable_dimension = aws_appautoscaling_target.dynamodb_table_write.scalable_dimension
#   service_namespace  = aws_appautoscaling_target.dynamodb_table_write.service_namespace

#   target_tracking_scaling_policy_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "DynamoDBWriteCapacityUtilization"
#     }

#     target_value = 70
#   }
# }
