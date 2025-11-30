resource "aws_sqs_queue" "karpenter_spot" {
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
  arn      = aws_sqs_queue.karpenter_spot.arn
  role_arn = aws_iam_role.event_bridge_send_sqs.arn
}
