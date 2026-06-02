locals {
  karpenter_interruption_rules = {
    scheduled_change = {
      description = "AWS Health scheduled change events"
      event_pattern = {
        source      = ["aws.health"]
        detail-type = ["AWS Health Event"]
      }
    }

    spot_interruption = {
      description = "EC2 Spot interruption warnings"
      event_pattern = {
        source      = ["aws.ec2"]
        detail-type = ["EC2 Spot Instance Interruption Warning"]
      }
    }

    rebalance_recommendation = {
      description = "EC2 Spot rebalance recommendations"
      event_pattern = {
        source      = ["aws.ec2"]
        detail-type = ["EC2 Instance Rebalance Recommendation"]
      }
    }

    instance_state_change = {
      description = "EC2 instance state changes"
      event_pattern = {
        source      = ["aws.ec2"]
        detail-type = ["EC2 Instance State-change Notification"]
      }
    }

    capacity_reservation_interruption = {
      description = "EC2 capacity reservation interruption warnings"
      event_pattern = {
        source      = ["aws.ec2"]
        detail-type = ["EC2 Capacity Reservation Instance Interruption Warning"]
      }
    }
  }
}

resource "aws_cloudwatch_event_rule" "karpenter_interruption" {
  for_each = local.karpenter_interruption_rules

  name          = "Karpenter-${aws_eks_cluster.main.name}-${each.key}"
  description   = each.value.description
  event_pattern = jsonencode(each.value.event_pattern)
}

resource "aws_cloudwatch_event_target" "karpenter_interruption" {
  for_each = aws_cloudwatch_event_rule.karpenter_interruption

  rule      = each.value.name
  target_id = "KarpenterInterruptionQueueTarget"
  arn       = aws_sqs_queue.karpenter_interruption.arn
}

resource "aws_sqs_queue" "karpenter_interruption" {
  name = "Karpenter-${aws_eks_cluster.main.name}-SpotInterruptionQueue"

  message_retention_seconds = 300
  sqs_managed_sse_enabled   = true
}


data "aws_iam_policy_document" "karpenter_interruption_queue" {
  statement {
    sid    = "AllowEventBridgeToSendMessages"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    actions = [
      "sqs:SendMessage"
    ]

    resources = [
      aws_sqs_queue.karpenter_interruption.arn
    ]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [for rule in aws_cloudwatch_event_rule.karpenter_interruption : rule.arn]
    }
  }

  statement {
    sid    = "DenyHTTP"
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "sqs:*"
    ]

    resources = [
      aws_sqs_queue.karpenter_interruption.arn
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

resource "aws_sqs_queue_policy" "karpenter_interruption" {
  queue_url = aws_sqs_queue.karpenter_interruption.id
  policy    = data.aws_iam_policy_document.karpenter_interruption_queue.json
}
