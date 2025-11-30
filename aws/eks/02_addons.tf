resource "aws_eks_addon" "vpc_cni" {
  cluster_name  = aws_eks_cluster.main.name
  addon_name    = "vpc-cni"
  addon_version = "v1.20.5-eksbuild.1"

  configuration_values = jsonencode({
    env = {
      AWS_VPC_K8S_CNI_CUSTOM_NETWORK_CFG = "true"
      ENI_CONFIG_LABEL_DEF               = "topology.kubernetes.io/zone"
    }
  })
}

resource "aws_eks_addon" "core_dns" {
  cluster_name  = aws_eks_cluster.main.name
  addon_name    = "coredns"
  addon_version = "v1.12.4-eksbuild.1"
}

# resource "aws_eks_addon" "pod_identity_agent" {
#   cluster_name  = aws_eks_cluster.main.name
#   addon_name    = "eks-pod-identity-agent"
#   addon_version = "v1.3.7-eksbuild.2"
# }

resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name             = aws_eks_cluster.main.name
  addon_name               = "aws-ebs-csi-driver"
  addon_version            = "v1.53.0-eksbuild.1"
  service_account_role_arn = aws_iam_role.ebs_csi_driver.arn
}

resource "aws_eks_addon" "csi_snapshot_controller" {
  cluster_name  = aws_eks_cluster.main.name
  addon_name    = "snapshot-controller"
  addon_version = "v8.3.0-eksbuild.1"
}

resource "aws_eks_addon" "metrics_server" {
  cluster_name  = aws_eks_cluster.main.name
  addon_name    = "metrics-server"
  addon_version = "v0.8.0-eksbuild.5"
}

# resource "aws_eks_addon" "kube_state_metrics" {
#   cluster_name  = aws_eks_cluster.main.name
#   addon_name    = "kube-state-metrics"
#   addon_version = "v2.15.0-eksbuild.4"
# }

# resource "aws_eks_addon" "prometheus_node_exporter" {
#   cluster_name  = aws_eks_cluster.main.name
#   addon_name    = "prometheus-node-exporter"
#   addon_version = "v1.9.1-eksbuild.2"
# }
