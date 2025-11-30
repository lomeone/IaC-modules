data "aws_caller_identity" "name" {}

resource "aws_eks_access_entry" "root_user" {
  cluster_name  = aws_eks_cluster.main.name
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.name.account_id}:root"
}

resource "aws_eks_access_policy_association" "root" {
  cluster_name  = aws_eks_cluster.main.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.name.account_id}:root"

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_access_entry" "cluster_admin" {
  for_each      = { for cluster_admin in var.access_entries.cluster_admins : cluster_admin => cluster_admin }
  cluster_name  = aws_eks_cluster.main.name
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.name.account_id}:user/${each.value}"
}

resource "aws_eks_access_policy_association" "cluster_admin" {
  for_each      = { for cluster_admin in var.access_entries.cluster_admins : cluster_admin => cluster_admin }
  cluster_name  = aws_eks_cluster.main.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.name.account_id}:user/${each.value}"

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_access_entry" "cluster_viewer" {
  for_each      = { for cluster_viewer in var.access_entries.cluster_viewers : cluster_viewer => cluster_viewer }
  cluster_name  = aws_eks_cluster.main.name
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.name.account_id}:user/${each.value}"
}

resource "aws_eks_access_policy_association" "cluster_viewer" {
  for_each      = { for cluster_viewer in var.access_entries.cluster_viewers : cluster_viewer => cluster_viewer }
  cluster_name  = aws_eks_cluster.main.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminViewPolicy"
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.name.account_id}:user/${each.value}"

  access_scope {
    type = "cluster"
  }
}
