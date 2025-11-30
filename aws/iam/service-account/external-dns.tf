resource "aws_iam_role" "external_dns" {
  name               = "ExternalDNSRole-${var.eks.name}"
  assume_role_policy = data.aws_iam_policy_document.eks_oidc_external_dns_assume_role.json
}

data "aws_iam_policy_document" "eks_oidc_external_dns_assume_role" {
  version = "2012-10-17"

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.eks.oidc_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:external-dns:external-dns"]
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

resource "aws_iam_role_policy_attachment" "external_dns_Route53AllowPolicy" {
  role       = aws_iam_role.external_dns.name
  policy_arn = aws_iam_policy.route53_allow.arn
}

resource "aws_iam_policy" "route53_allow" {
  name   = "Route53AllowPolicy-${var.eks.name}"
  policy = data.aws_iam_policy_document.route53_allow_policy.json
}

data "aws_iam_policy_document" "route53_allow_policy" {
  version = "2012-10-17"

  statement {
    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResources"
    ]

    effect = "Allow"

    resources = ["arn:aws:route53:::hostedzone/*"]
  }

  statement {
    actions = [
      "route53:ListHostedZones",
    ]

    effect = "Allow"

    resources = ["*"]
  }
}
