resource "aws_iam_role" "argocd_image_updater" {
  name               = "ArgoCDImageUpdaterRole-${var.eks.name}"
  assume_role_policy = data.aws_iam_policy_document.eks_oidc_argocd_image_updater_assume_role.json
}

data "aws_iam_policy_document" "eks_oidc_argocd_image_updater_assume_role" {
  version = "2012-10-17"

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringLike"
      variable = "${replace(var.eks.oidc_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:argo:argocd-image-updater"]
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

resource "aws_iam_role_policy_attachment" "argocd_image_updater_AmazonEC2ContainerRegistryFullAccess" {
  role       = aws_iam_role.argocd_image_updater.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}
