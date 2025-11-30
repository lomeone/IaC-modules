data "aws_subnet" "pod_custom_networking" {
  count = length(var.vpc.subnet_ids.pod_custom_networking)
  id    = var.vpc.subnet_ids.pod_custom_networking[count.index]
}

resource "kubernetes_manifest" "eni_config" {
  count = length(var.vpc.subnet_ids.pod_custom_networking)
  manifest = {
    apiVersion = "crd.k8s.amazonaws.com/v1alpha1"
    kind       = "ENIConfig"
    metadata = {
      name = "${data.aws_subnet.pod_custom_networking[count.index].availability_zone}"
    }
    spec = {
      securityGroups = [
        aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
      ]
      subnet = "${data.aws_subnet.pod_custom_networking[count.index].id}"
    }
  }
}
