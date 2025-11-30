
resource "aws_iam_role" "redpanda" {
  name               = "RedpandaRole-${var.eks.name}"
  assume_role_policy = data.aws_iam_policy_document.eks_oidc_redpanda_assume_role.json
}

data "aws_iam_policy_document" "eks_oidc_redpanda_assume_role" {
  version = "2012-10-17"

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.eks.oidc_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kafka-system:redpanda-console"]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(var.eks.oidc_url, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }

    principals {
      identifiers = [var.eks.oidc_arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role_policy_attachment" "redpanda_KafkaClusterAllowRedpandaPolicy" {
  role       = aws_iam_role.redpanda.name
  policy_arn = aws_iam_policy.kafka_cluster_allow_redpanda.arn
}

resource "aws_iam_policy" "kafka_cluster_allow_redpanda" {
  name   = "KafkaClusterAllowRedpandaPolicy"
  policy = data.aws_iam_policy_document.kafka_cluster_allow_redpanda_policy.json
}

data "aws_iam_policy_document" "kafka_cluster_allow_redpanda_policy" {
  version = "2012-10-17"

  statement {
    actions = ["kafka-cluster:*"]

    effect = "Allow"

    resources = [
      "arn:aws:kafka:ap-northeast-2:058264332540:cluster/hansu-msk/*",
      "arn:aws:kafka:ap-northeast-2:058264332540:group/hansu-msk/*",
      "arn:aws:kafka:ap-northeast-2:058264332540:topic/hansu-msk/*",
      "arn:aws:kafka:ap-northeast-2:058264332540:transactional-id/hansu-msk/*"
    ]
  }
}
