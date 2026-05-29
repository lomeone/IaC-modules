resource "aws_iam_openid_connect_provider" "eks_oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_tls.certificates[0].sha1_fingerprint]
  url             = data.tls_certificate.eks_tls.url
}

ephemeral "aws_eks_cluster_auth" "main" {
  name = aws_eks_cluster.main.name
}

# If use terraform cloud
# You need eks access entry add terraform cloud role
provider "kubernetes" {
  host                   = aws_eks_cluster.main.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority[0].data)
  token                  = ephemeral.aws_eks_cluster_auth.main.token
}

provider "helm" {
  kubernetes = {
    host                   = aws_eks_cluster.main.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority[0].data)
    token                  = ephemeral.aws_eks_cluster_auth.main.token
  }
}
