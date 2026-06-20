resource "aws_ec2_managed_prefix_list" "main" {
  for_each = var.prefix_lists

  name           = each.key
  address_family = each.value.address_family
  max_entries    = each.value.max_entries

  tags = merge(each.value.tags, {
    Name = each.key
  })
}

locals {
  entries = merge([
    for name, pl in var.prefix_lists : {
      for cidr in pl.entries : "${name}/${cidr}" => {
        prefix_list_id = aws_ec2_managed_prefix_list.main[name].id
        cidr           = cidr
      }
    }
  ]...)
}

resource "aws_ec2_managed_prefix_list_entry" "main" {
  for_each = local.entries

  prefix_list_id = each.value.prefix_list_id
  cidr           = each.value.cidr
}
