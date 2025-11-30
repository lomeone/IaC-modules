resource "helm_release" "aws_loadbalancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.16.0"

  namespace = "kube-system"

  values = [<<EOF
autoscaling:
  enabled: true

serviceAccount:
  annotations:
    eks.amazonaws.com/role-arn: ${aws_iam_role.aws_lb_controller.arn}

resources:
  requests:
    cpu: 100m
    memory: 128Mi
  limits:
    memory: 128Mi

clusterName: ${aws_eks_cluster.main.name}

region: ${var.region}

vpcId: ${var.vpc.id}
  EOF
  ]
}
