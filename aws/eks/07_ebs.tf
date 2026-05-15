data "aws_eks_addon_version" "ebs_csi_driver" {
  addon_name         = "aws-ebs-csi-driver"
  kubernetes_version = aws_eks_cluster.main.version
}

resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name             = aws_eks_cluster.main.name
  addon_name               = "aws-ebs-csi-driver"
  addon_version            = data.aws_eks_addon_version.ebs_csi_driver.version
  service_account_role_arn = aws_iam_role.ebs_csi_driver.arn
}

resource "kubernetes_manifest" "gp3_storage_class" {
  manifest = {
    apiVersion = "storage.k8s.io/v1"
    kind       = "StorageClass"
    metadata = {
      name = "gp3"
    }
    provisioner = "ebs.csi.aws.com"
    parameters = {
      type                        = "gp3"
      encrypted                   = "true"
      "csi.storage.k8s.io/fstype" = "ext4"
      iops                        = "3000"
      throughput                  = "125"
    }
    volumeBindingMode    = "WaitForFirstConsumer"
    reclaimPolicy        = "Delete"
    allowVolumeExpansion = true
  }
}

resource "kubernetes_manifest" "gp3_retain_storage_class" {
  manifest = {
    apiVersion = "storage.k8s.io/v1"
    kind       = "StorageClass"

    metadata = {
      name = "gp3-retain"
    }

    provisioner = "ebs.csi.aws.com"

    parameters = {
      type                        = "gp3"
      encrypted                   = "true"
      "csi.storage.k8s.io/fstype" = "ext4"
    }

    volumeBindingMode    = "WaitForFirstConsumer"
    reclaimPolicy        = "Retain"
    allowVolumeExpansion = true
  }
}
