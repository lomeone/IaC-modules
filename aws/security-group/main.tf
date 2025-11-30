locals {
  ingress_cidr_block_v4     = [for rule in var.security_group_info.ingress : rule if rule.cidr_block_v4 != null]
  ingress_cidr_block_v6     = [for rule in var.security_group_info.ingress : rule if rule.cidr_block_v6 != null]
  ingress_security_group_id = [for rule in var.security_group_info.ingress : rule if rule.security_group_id != null]
  ingress_prefix_list_id    = [for rule in var.security_group_info.ingress : rule if rule.prefix_list_id != null]

  egress_cidr_block_v4     = [for rule in var.security_group_info.egress : rule if rule.cidr_block_v4 != null]
  egress_cidr_block_v6     = [for rule in var.security_group_info.egress : rule if rule.cidr_block_v6 != null]
  egress_security_group_id = [for rule in var.security_group_info.egress : rule if rule.security_group_id != null]
  egress_prefix_list_id    = [for rule in var.security_group_info.egress : rule if rule.prefix_list_id != null]
}

resource "aws_security_group" "this" {
  name        = "${var.vpc.name}-${var.security_group_info.name}"
  vpc_id      = var.vpc.id
  description = var.security_group_info.description

  tags = var.security_group_info.tags
}

resource "aws_vpc_security_group_ingress_rule" "ip_v4" {
  count = length(local.ingress_cidr_block_v4)

  security_group_id = aws_security_group.this.id

  ip_protocol = local.ingress_cidr_block_v4[count.index].protocol
  from_port   = local.ingress_cidr_block_v4[count.index].from_port
  to_port     = local.ingress_cidr_block_v4[count.index].to_port
  cidr_ipv4   = local.ingress_cidr_block_v4[count.index].cidr_block_v4
}

resource "aws_vpc_security_group_ingress_rule" "ip_v6" {
  count = length(local.ingress_cidr_block_v6)

  security_group_id = aws_security_group.this.id

  ip_protocol = local.ingress_cidr_block_v6[count.index].protocol
  from_port   = local.ingress_cidr_block_v6[count.index].from_port
  to_port     = local.ingress_cidr_block_v6[count.index].to_port
  cidr_ipv6   = local.ingress_cidr_block_v6[count.index].cidr_block_v6
}

resource "aws_vpc_security_group_ingress_rule" "security_group" {
  count = length(local.ingress_security_group_id)

  security_group_id = aws_security_group.this.id

  ip_protocol                  = local.ingress_security_group_id[count.index].protocol
  from_port                    = local.ingress_security_group_id[count.index].from_port
  to_port                      = local.ingress_security_group_id[count.index].to_port
  referenced_security_group_id = local.ingress_security_group_id[count.index].security_group_id
}

resource "aws_vpc_security_group_ingress_rule" "prefix_list" {
  count = length(local.ingress_prefix_list_id)

  security_group_id = aws_security_group.this.id

  ip_protocol    = local.ingress_prefix_list_id[count.index].protocol
  from_port      = local.ingress_prefix_list_id[count.index].from_port
  to_port        = local.ingress_prefix_list_id[count.index].to_port
  prefix_list_id = local.ingress_prefix_list_id[count.index].prefix_list_id
}

resource "aws_vpc_security_group_egress_rule" "ip_v4" {
  count = length(local.egress_cidr_block_v4)

  security_group_id = aws_security_group.this.id

  ip_protocol = local.egress_cidr_block_v4[count.index].protocol
  from_port   = local.egress_cidr_block_v4[count.index].from_port
  to_port     = local.egress_cidr_block_v4[count.index].to_port
  cidr_ipv4   = local.egress_cidr_block_v4[count.index].cidr_block_v4
}

resource "aws_vpc_security_group_egress_rule" "ip_v6" {
  count = length(local.egress_cidr_block_v6)

  security_group_id = aws_security_group.this.id

  ip_protocol = local.egress_cidr_block_v6[count.index].protocol
  from_port   = local.egress_cidr_block_v6[count.index].from_port
  to_port     = local.egress_cidr_block_v6[count.index].to_port
  cidr_ipv6   = local.egress_cidr_block_v6[count.index].cidr_block_v6
}

resource "aws_vpc_security_group_egress_rule" "security_group" {
  count = length(local.egress_security_group_id)

  security_group_id = aws_security_group.this.id

  ip_protocol                  = local.egress_security_group_id[count.index].protocol
  from_port                    = local.egress_security_group_id[count.index].from_port
  to_port                      = local.egress_security_group_id[count.index].to_port
  referenced_security_group_id = local.egress_security_group_id[count.index].security_group_id
}

resource "aws_vpc_security_group_egress_rule" "prefix_list" {
  count = length(local.egress_prefix_list_id)

  security_group_id = aws_security_group.this.id

  ip_protocol    = local.egress_prefix_list_id[count.index].protocol
  from_port      = local.egress_prefix_list_id[count.index].from_port
  to_port        = local.egress_prefix_list_id[count.index].to_port
  prefix_list_id = local.egress_prefix_list_id[count.index].prefix_list_id
}
