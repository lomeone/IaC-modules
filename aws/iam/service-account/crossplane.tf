resource "aws_iam_role" "crossplane" {
  name               = "CrossplaneRole-${var.eks.name}"
  assume_role_policy = data.aws_iam_policy_document.eks_oidc_crossplane_assume_role.json
}

data "aws_iam_policy_document" "eks_oidc_crossplane_assume_role" {
  version = "2012-10-17"

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringLike"
      variable = "${replace(var.eks.oidc_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:crossplane-system:upbound-provider-aws-*"]
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

resource "aws_iam_role_policy_attachment" "crossplane_AdministratorAccess" {
  role       = aws_iam_role.crossplane.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
