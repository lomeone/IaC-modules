output "eks_info" {
  value = {
    name     = aws_eks_cluster.main.name
    arn      = aws_eks_cluster.main.arn
    oidc_arn = aws_iam_openid_connect_provider.eks_oidc.arn
    oidc_url = aws_iam_openid_connect_provider.eks_oidc.url
  }
}
