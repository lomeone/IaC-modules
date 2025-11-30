output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_name" {
  value = var.name.vpc
}

output "subnet_ids" {
  value = {
    public_subnets        = aws_subnet.public[*].id
    eks_control_plane     = aws_subnet.eks_control_plane[*].id
    private_subnets       = aws_subnet.private[*].id
    db_private_subnets    = aws_subnet.db_private[*].id
    pod_custom_networking = aws_subnet.pod_custom_networking[*].id
  }
}

output "subnet_groups" {
  value = {
    db = aws_db_subnet_group.default.name
  }
}

output "route_table_id" {
  value = {
    public                = aws_route_table.public.id
    private               = aws_route_table.private.id
    pod_custom_networking = aws_route_table.pod_custom_networking.id
  }
}
