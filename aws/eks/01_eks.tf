resource "aws_eks_cluster" "main" {
  name     = var.name.eks
  role_arn = aws_iam_role.eks.arn
  vpc_config {
    subnet_ids              = var.vpc.subnet_ids.control_plane
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  version = "1.33"

  kubernetes_network_config {
    service_ipv4_cidr = var.network.service_ipv4_cidr
  }

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

  tags = {
    "karpenter.sh/discovery" = "${var.name.eks}"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks_AmazonEKSVPCResourceController
  ]
}

data "tls_certificate" "eks_tls" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

data "aws_ssm_parameter" "eks_ami_release_version" {
  name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.main.version}/amazon-linux-2023/arm64/standard/recommended/release_version"
}

resource "aws_eks_node_group" "default_node_group" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "default_node_group"
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = var.vpc.subnet_ids.node
  # release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)
  release_version = "1.33.5-20251120"

  scaling_config {
    desired_size = var.node_group.desired_size
    max_size     = var.node_group.max_size
    min_size     = var.node_group.min_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_group_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_group_AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.node_group_AmazonEKS_CNI_Policy
  ]

  ami_type = "AL2023_ARM_64_STANDARD"

  instance_types = var.node_group.node_instance_type

  taint {
    key    = "node.cilium.io/agent-not-ready"
    value  = "true"
    effect = "NO_EXECUTE"
  }
}

resource "null_resource" "add_karpenter_tag" {
  count = length(var.vpc.subnet_ids.node)

  provisioner "local-exec" {
    command = <<EOT
      aws ec2 create-tags --region ${var.region} --resources ${aws_eks_cluster.main.vpc_config[0].cluster_security_group_id} --tags Key=karpenter.sh/discovery,Value=${aws_eks_cluster.main.name}
    EOT
  }
}
