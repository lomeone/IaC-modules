## Requirements

No requirements.

## Providers

| Name                                                                  | Version |
| --------------------------------------------------------------------- | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws)                      | n/a     |
| <a name="provider_helm"></a> [helm](#provider_helm)                   | n/a     |
| <a name="provider_kubernetes"></a> [kubernetes](#provider_kubernetes) | n/a     |
| <a name="provider_null"></a> [null](#provider_null)                   | n/a     |
| <a name="provider_tls"></a> [tls](#provider_tls)                      | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                                             | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------- |
| [aws_cloudwatch_event_rule.karpenter_node_autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule)                                        | resource    |
| [aws_cloudwatch_event_target.node_autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target)                                              | resource    |
| [aws_eks_access_entry.cluster_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_access_entry)                                                               | resource    |
| [aws_eks_access_entry.cluster_viewer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_access_entry)                                                              | resource    |
| [aws_eks_access_entry.root_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_access_entry)                                                                   | resource    |
| [aws_eks_access_policy_association.cluster_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_access_policy_association)                                     | resource    |
| [aws_eks_access_policy_association.cluster_viewer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_access_policy_association)                                    | resource    |
| [aws_eks_access_policy_association.root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_access_policy_association)                                              | resource    |
| [aws_eks_addon.core_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon)                                                                                  | resource    |
| [aws_eks_addon.csi_snapshot_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon)                                                                   | resource    |
| [aws_eks_addon.ebs_csi_driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon)                                                                            | resource    |
| [aws_eks_addon.metrics_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon)                                                                            | resource    |
| [aws_eks_addon.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon)                                                                                   | resource    |
| [aws_eks_cluster.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster)                                                                                  | resource    |
| [aws_eks_node_group.default_node_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group)                                                              | resource    |
| [aws_iam_openid_connect_provider.eks_oidc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider)                                              | resource    |
| [aws_iam_policy.aws_lb_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)                                                                       | resource    |
| [aws_iam_policy.ecr_pull](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)                                                                                | resource    |
| [aws_iam_policy.event_bridge_send_sqs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)                                                                   | resource    |
| [aws_iam_policy.karpenter_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)                                                                    | resource    |
| [aws_iam_role.aws_lb_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                                                           | resource    |
| [aws_iam_role.ebs_csi_driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                                                              | resource    |
| [aws_iam_role.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                                                                         | resource    |
| [aws_iam_role.event_bridge_send_sqs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                                                       | resource    |
| [aws_iam_role.karpenter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                                                                   | resource    |
| [aws_iam_role.karpenter_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                                                        | resource    |
| [aws_iam_role.node_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                                                                  | resource    |
| [aws_iam_role_policy_attachment.aws_lb_controller_AmazonEKSLoadBalancerControllerPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource    |
| [aws_iam_role_policy_attachment.eks_AmazonEKSClusterPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)                              | resource    |
| [aws_iam_role_policy_attachment.eks_AmazonEKSVPCResourceController](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)                      | resource    |
| [aws_iam_role_policy_attachment.event_bridge_send_sqs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)                                   | resource    |
| [aws_iam_role_policy_attachment.karpenter_AmazonEC2ContainerRegistryReadOnly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)            | resource    |
| [aws_iam_role_policy_attachment.karpenter_AmazonEKSWorkerNodePolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)                     | resource    |
| [aws_iam_role_policy_attachment.karpenter_AmazonEKS_CNI_Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)                          | resource    |
| [aws_iam_role_policy_attachment.karpenter_AmazonSSMManagedInstanceCore](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)                  | resource    |
| [aws_iam_role_policy_attachment.karpenter_ECRPullPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)                                 | resource    |
| [aws_iam_role_policy_attachment.karpenter_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)                                    | resource    |
| [aws_iam_role_policy_attachment.name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)                                                    | resource    |
| [aws_iam_role_policy_attachment.node_group_AmazonEC2ContainerRegistryReadOnly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)           | resource    |
| [aws_iam_role_policy_attachment.node_group_AmazonEKSWorkerNodePolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)                    | resource    |
| [aws_iam_role_policy_attachment.node_group_AmazonEKS_CNI_Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)                         | resource    |
| [aws_iam_role_policy_attachment.node_group_ECRPullPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)                                | resource    |
| [aws_iam_service_linked_role.spot](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role)                                                          | resource    |
| [aws_sqs_queue.karpenter_spot](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue)                                                                            | resource    |
| [helm_release.aws_loadbalancer_controller](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                                                                 | resource    |
| [kubernetes_manifest.eni_config](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest)                                                                    | resource    |
| [null_resource.add_karpenter_tag](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource)                                                                         | resource    |
| [aws_caller_identity.name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)                                                                       | data source |
| [aws_eks_cluster.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster)                                                                               | data source |
| [aws_eks_cluster_auth.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth)                                                                     | data source |
| [aws_iam_policy_document.aws_lb_controller_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                                             | data source |
| [aws_iam_policy_document.ebs_csi_driver_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                                                | data source |
| [aws_iam_policy_document.ecr_pull_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                                                    | data source |
| [aws_iam_policy_document.eks_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                                                           | data source |
| [aws_iam_policy_document.event_bridge_send_sqs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                                       | data source |
| [aws_iam_policy_document.event_bridge_send_sqs_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                                         | data source |
| [aws_iam_policy_document.karpenter_controller_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                                        | data source |
| [aws_iam_policy_document.karpenter_controller_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                                          | data source |
| [aws_iam_policy_document.node_group_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                                                    | data source |
| [aws_ssm_parameter.eks_ami_release_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter)                                                        | data source |
| [aws_subnet.pod_custom_networking](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet)                                                                        | data source |
| [tls_certificate.eks_tls](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate)                                                                            | data source |

## Inputs

| Name                                                                        | Description     | Type                                                                                                                                                                                                                                             | Default                                                                                                                                 | Required |
| --------------------------------------------------------------------------- | --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------- | :------: |
| <a name="input_access_entries"></a> [access_entries](#input_access_entries) | n/a             | <pre>object({<br/> cluster_admins = optional(list(string), [])<br/> cluster_viewers = optional(list(string), [])<br/> })</pre>                                                                                                                   | <pre>{<br/> "cluster_admins": [],<br/> "cluster_viewers": []<br/>}</pre>                                                                |    no    |
| <a name="input_name"></a> [name](#input_name)                               | resource name   | <pre>object({<br/> eks = string<br/> })</pre>                                                                                                                                                                                                    | <pre>{<br/> "eks": "default"<br/>}</pre>                                                                                                |    no    |
| <a name="input_network"></a> [network](#input_network)                      | n/a             | <pre>object({<br/> service_ipv4_cidr = string<br/> })</pre>                                                                                                                                                                                      | <pre>{<br/> "service_ipv4_cidr": "172.20.0.0/16"<br/>}</pre>                                                                            |    no    |
| <a name="input_node_group"></a> [node_group](#input_node_group)             | n/a             | <pre>object({<br/> node_instance_type = list(string)<br/> min_size = number<br/> max_size = number<br/> desired_size = number<br/> })</pre>                                                                                                      | <pre>{<br/> "desired_size": 1,<br/> "max_size": 3,<br/> "min_size": 1,<br/> "node_instance_type": [<br/> "t4g.large"<br/> ]<br/>}</pre> |    no    |
| <a name="input_region"></a> [region](#input_region)                         | service region  | `string`                                                                                                                                                                                                                                         | `"ap-northeast-2"`                                                                                                                      |    no    |
| <a name="input_vpc"></a> [vpc](#input_vpc)                                  | vpc information | <pre>object({<br/> id = string<br/> name = string<br/> pod_custom_networking_cidr = string<br/> subnet_ids = object({<br/> control_plane = list(string)<br/> node = list(string)<br/> pod_custom_networking = list(string)<br/> })<br/> })</pre> | n/a                                                                                                                                     |   yes    |

## Outputs

| Name                                                        | Description |
| ----------------------------------------------------------- | ----------- |
| <a name="output_eks_info"></a> [eks_info](#output_eks_info) | n/a         |
