resource "aws_route53_record" "records" {
  for_each = {
    for idx, record in var.records :
    "${record.name}-${record.type}" => record
  }
  zone_id = aws_route53_zone.main.zone_id

  name    = each.value.name
  type    = each.value.type
  ttl     = each.value.ttl
  records = each.value.records
}

resource "aws_route53_record" "aliases" {
  for_each = {
    for idx, record in var.aliases :
    "${record.name}-${record.zone_id}-${record.type}" => record
  }
  zone_id = aws_route53_zone.main.zone_id

  name = each.value.name
  type = each.value.type
  alias {
    name                   = each.value.alias
    zone_id                = each.value.zone_id
    evaluate_target_health = lookup(each.value, "evaluate_target_health", false)
  }
}
