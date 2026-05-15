resource "helm_release" "aws_loadbalancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "3.3.0"

  namespace = "kube-system"

  values = [<<EOF
image:
  repository: 396428372646.dkr.ecr.ap-northeast-2.amazonaws.com/ecr-public/eks/aws-load-balancer-controller

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
