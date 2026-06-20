terraform {
  required_version = ">= 1.14.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.21.0"
    }
  }
}

locals {
  proxiable_types = toset(["A", "AAAA", "CNAME"])

  normalized_records = [
    for record in var.records : {
      subdomain = (
        record.subdomain == ""
        ? "@"
        : trimsuffix(record.subdomain, ".")
      )

      type     = upper(record.type)
      contents = distinct(record.contents)

      ttl      = record.ttl
      proxied  = record.proxied
      priority = record.priority
      comment  = record.comment
      tags     = record.tags
    }
  ]

  expanded_records = flatten([
    for record in local.normalized_records : [
      for content in record.contents : {
        subdomain = record.subdomain

        name = (
          record.subdomain == "@"
          ? "@"
          : record.subdomain
        )

        type    = record.type
        content = content

        ttl      = record.ttl
        proxied  = contains(local.proxiable_types, record.type) ? record.proxied : null
        priority = record.priority
        comment  = record.comment
        tags     = record.tags

        key = join("_", compact([
          replace(record.subdomain, ".", "__"),
          record.type,
          record.priority == null ? "" : tostring(record.priority),
          substr(sha1(content), 0, 12),
        ]))
      }
    ]
  ])

  expanded_record_map = {
    for record in local.expanded_records :
    record.key => record
  }
}

resource "cloudflare_dns_record" "main" {
  for_each = local.expanded_record_map

  zone_id = var.zone_id

  name    = each.value.name
  type    = each.value.type
  content = each.value.content
  ttl     = each.value.ttl

  proxied  = each.value.proxied
  priority = each.value.priority
  comment  = each.value.comment
  tags     = each.value.tags

  lifecycle {
    ignore_changes = [
      "modified_on",
    ]
  }
}
