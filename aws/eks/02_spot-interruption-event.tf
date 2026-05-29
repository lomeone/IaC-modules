resource "aws_sqs_queue" "karpenter_interruption" {
  name = "Karpenter-${aws_eks_cluster.main.name}-SpotInterruptionQueue"

  message_retention_seconds = 300
  sqs_managed_sse_enabled   = true
}

resource "aws_cloudwatch_event_rule" "karpenter_node_autoscaling" {
  name        = "Karpenter-${aws_eks_cluster.main.name}-NodeAutoscalingRule"
  description = "This rule is used to route Instance notifications to EC2 Auto Scaling at Karpenter"
  event_pattern = jsonencode({
    "source" = [
      "aws.ec2",
      "aws.health"
    ],
    detail-type = [
      "EC2 Instance Rebalance Recommendation",
      "EC2 Spot Instance Interruption Warning",
      "EC2 Instance State-change Notification",
      "AWS Health Event"
    ],
    detail : {
      state : [ # EC2 Instance State-change Notification 필터
        "shutting-down",
        "terminated",
        "stopping",
        "stopped"
      ],
      service : [ # AWS Health Event 필터 (서비스)
        "EC2"
      ],
      eventTypeCategory : [ # AWS Health Event 필터 (유형)
        "scheduledChange"
      ]
    }
  })
}

resource "aws_cloudwatch_event_target" "node_autoscaling" {
  rule     = aws_cloudwatch_event_rule.karpenter_node_autoscaling.name
  arn      = aws_sqs_queue.karpenter_interruption.arn
  role_arn = aws_iam_role.event_bridge_send_sqs.arn
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
      values   = [for rule in aws_cloudwatch_event_rule.karpenter_node_autoscaling : rule.arn]
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
