data "aws_eks_addon_version" "vpc_cni" {
  addon_name         = "vpc-cni"
  kubernetes_version = aws_eks_cluster.main.version
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name  = aws_eks_cluster.main.name
  addon_name    = "vpc-cni"
  addon_version = data.aws_eks_addon_version.vpc_cni.version

  configuration_values = jsonencode({
    env = {
      AWS_VPC_K8S_CNI_CUSTOM_NETWORK_CFG = "true"
      ENI_CONFIG_LABEL_DEF               = "topology.kubernetes.io/zone"
    }
  })
}

data "aws_eks_addon_version" "core_dns" {
  addon_name         = "coredns"
  kubernetes_version = aws_eks_cluster.main.version
}

resource "aws_eks_addon" "core_dns" {
  cluster_name  = aws_eks_cluster.main.name
  addon_name    = "coredns"
  addon_version = data.aws_eks_addon_version.core_dns.version
}

# resource "aws_eks_addon" "pod_identity_agent" {
#   cluster_name  = aws_eks_cluster.main.name
#   addon_name    = "eks-pod-identity-agent"
#   addon_version = "v1.3.7-eksbuild.2"
# }

data "aws_eks_addon_version" "csi_snapshot_controller" {
  addon_name         = "snapshot-controller"
  kubernetes_version = aws_eks_cluster.main.version
}

resource "aws_eks_addon" "csi_snapshot_controller" {
  cluster_name  = aws_eks_cluster.main.name
  addon_name    = "snapshot-controller"
  addon_version = data.aws_eks_addon_version.csi_snapshot_controller.version
}

data "aws_eks_addon_version" "metrics_server" {
  addon_name         = "metrics-server"
  kubernetes_version = aws_eks_cluster.main.version
}

resource "aws_eks_addon" "metrics_server" {
  cluster_name  = aws_eks_cluster.main.name
  addon_name    = "metrics-server"
  addon_version = data.aws_eks_addon_version.metrics_server.version
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
