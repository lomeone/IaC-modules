locals {
  ingress_cidr_block_v4     = { for rule in var.security_group_info.ingress : "${rule.protocol}-${rule.from_port}-${rule.to_port}-${rule.cidr_block_v4}" => rule if rule.cidr_block_v4 != null }
  ingress_cidr_block_v6     = { for rule in var.security_group_info.ingress : "${rule.protocol}-${rule.from_port}-${rule.to_port}-${rule.cidr_block_v6}" => rule if rule.cidr_block_v6 != null }
  ingress_security_group_id = { for rule in var.security_group_info.ingress : "${rule.protocol}-${rule.from_port}-${rule.to_port}-${rule.security_group_id}" => rule if rule.security_group_id != null }
  ingress_prefix_list_id    = { for rule in var.security_group_info.ingress : "${rule.protocol}-${rule.from_port}-${rule.to_port}-${rule.prefix_list_id}" => rule if rule.prefix_list_id != null }
  ingress_self              = { for rule in var.security_group_info.ingress : "${rule.protocol}-${rule.from_port}-${rule.to_port}-self" => rule if rule.allow_self }

  egress_cidr_block_v4     = { for rule in var.security_group_info.egress : "${rule.protocol}-${rule.from_port}-${rule.to_port}-${rule.cidr_block_v4}" => rule if rule.cidr_block_v4 != null }
  egress_cidr_block_v6     = { for rule in var.security_group_info.egress : "${rule.protocol}-${rule.from_port}-${rule.to_port}-${rule.cidr_block_v6}" => rule if rule.cidr_block_v6 != null }
  egress_security_group_id = { for rule in var.security_group_info.egress : "${rule.protocol}-${rule.from_port}-${rule.to_port}-${rule.security_group_id}" => rule if rule.security_group_id != null }
  egress_prefix_list_id    = { for rule in var.security_group_info.egress : "${rule.protocol}-${rule.from_port}-${rule.to_port}-${rule.prefix_list_id}" => rule if rule.prefix_list_id != null }
  egress_self              = { for rule in var.security_group_info.egress : "${rule.protocol}-${rule.from_port}-${rule.to_port}-self" => rule if rule.allow_self }
}

resource "aws_security_group" "this" {
  name        = "${var.vpc.name}-${var.security_group_info.name}"
  vpc_id      = var.vpc.id
  description = var.security_group_info.description

  tags = var.security_group_info.tags
}

resource "aws_vpc_security_group_ingress_rule" "ip_v4" {
  for_each = local.ingress_cidr_block_v4

  security_group_id = aws_security_group.this.id

  ip_protocol = each.value.protocol
  from_port   = each.value.protocol == "-1" ? null : each.value.from_port
  to_port     = each.value.protocol == "-1" ? null : each.value.to_port
  cidr_ipv4   = each.value.cidr_block_v4
}

resource "aws_vpc_security_group_ingress_rule" "ip_v6" {
  for_each = local.ingress_cidr_block_v6

  security_group_id = aws_security_group.this.id

  ip_protocol = each.value.protocol
  from_port   = each.value.protocol == "-1" ? null : each.value.from_port
  to_port     = each.value.protocol == "-1" ? null : each.value.to_port
  cidr_ipv6   = each.value.cidr_block_v6
}

resource "aws_vpc_security_group_ingress_rule" "security_group" {
  for_each = local.ingress_security_group_id

  security_group_id = aws_security_group.this.id

  ip_protocol                  = each.value.protocol
  from_port                    = each.value.protocol == "-1" ? null : each.value.from_port
  to_port                      = each.value.protocol == "-1" ? null : each.value.to_port
  referenced_security_group_id = each.value.security_group_id
}

resource "aws_vpc_security_group_ingress_rule" "prefix_list" {
  for_each = local.ingress_prefix_list_id

  security_group_id = aws_security_group.this.id

  ip_protocol    = each.value.protocol
  from_port      = each.value.protocol == "-1" ? null : each.value.from_port
  to_port        = each.value.protocol == "-1" ? null : each.value.to_port
  prefix_list_id = each.value.prefix_list_id
}

resource "aws_vpc_security_group_ingress_rule" "self" {
  for_each = local.ingress_self

  security_group_id = aws_security_group.this.id

  ip_protocol                  = each.value.protocol
  from_port                    = each.value.protocol == "-1" ? null : each.value.from_port
  to_port                      = each.value.protocol == "-1" ? null : each.value.to_port
  referenced_security_group_id = aws_security_group.this.id
}

resource "aws_vpc_security_group_egress_rule" "ip_v4" {
  for_each = local.egress_cidr_block_v4

  security_group_id = aws_security_group.this.id

  ip_protocol = each.value.protocol
  from_port   = each.value.protocol == "-1" ? null : each.value.from_port
  to_port     = each.value.protocol == "-1" ? null : each.value.to_port
  cidr_ipv4   = each.value.cidr_block_v4
}

resource "aws_vpc_security_group_egress_rule" "ip_v6" {
  for_each = local.egress_cidr_block_v6

  security_group_id = aws_security_group.this.id

  ip_protocol = each.value.protocol
  from_port   = each.value.protocol == "-1" ? null : each.value.from_port
  to_port     = each.value.protocol == "-1" ? null : each.value.to_port
  cidr_ipv6   = each.value.cidr_block_v6
}

resource "aws_vpc_security_group_egress_rule" "security_group" {
  for_each = local.egress_security_group_id

  security_group_id = aws_security_group.this.id

  ip_protocol                  = each.value.protocol
  from_port                    = each.value.protocol == "-1" ? null : each.value.from_port
  to_port                      = each.value.protocol == "-1" ? null : each.value.to_port
  referenced_security_group_id = each.value.security_group_id
}

resource "aws_vpc_security_group_egress_rule" "prefix_list" {
  for_each = local.egress_prefix_list_id

  security_group_id = aws_security_group.this.id

  ip_protocol    = each.value.protocol
  from_port      = each.value.protocol == "-1" ? null : each.value.from_port
  to_port        = each.value.protocol == "-1" ? null : each.value.to_port
  prefix_list_id = each.value.prefix_list_id
}

resource "aws_vpc_security_group_egress_rule" "self" {
  for_each = local.egress_self

  security_group_id = aws_security_group.this.id

  ip_protocol                  = each.value.protocol
  from_port                    = each.value.protocol == "-1" ? null : each.value.from_port
  to_port                      = each.value.protocol == "-1" ? null : each.value.to_port
  referenced_security_group_id = aws_security_group.this.id
}
