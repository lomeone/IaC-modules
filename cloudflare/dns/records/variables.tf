variable "zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}

variable "domain" {
  description = "Root domain (e.g. lomeone.com)"
  type        = string
}

variable "records" {
  description = "List of Cloudflare DNS records. contents is expanded into multiple cloudflare_dns_record resources."
  type = list(object({
    subdomain = string
    type      = string

    # Route53 records = [] 와 유사하게 입력
    contents = list(string)

    ttl      = optional(number, 1)
    proxied  = optional(bool, false)
    priority = optional(number, null)
    comment  = optional(string, "")
    tags     = optional(list(string), [])
  }))

  validation {
    condition = alltrue([
      for record in var.records :
      length(record.contents) > 0
    ])
    error_message = "Each record must have at least one content."
  }

  validation {
    condition = alltrue([
      for record in var.records :
      contains([
        "A",
        "AAAA",
        "CNAME",
        "MX",
        "NS",
        "OPENPGPKEY",
        "PTR",
        "TXT",
        "CAA",
        "CERT",
        "DNSKEY",
        "DS",
        "HTTPS",
        "LOC",
        "NAPTR",
        "SMIMEA",
        "SRV",
        "SSHFP",
        "SVCB",
        "TLSA",
        "URI"
      ], upper(record.type))
    ])
    error_message = "Unsupported DNS record type."
  }

  validation {
    condition = alltrue([
      for record in var.records :
      record.ttl == 1 || (record.ttl >= 60 && record.ttl <= 86400)
    ])
    error_message = "TTL must be 1 for automatic, or between 60 and 86400 seconds."
  }

  validation {
    condition = alltrue([
      for record in var.records :
      upper(record.type) != "CNAME" || length(record.contents) == 1
    ])
    error_message = "CNAME records must have exactly one content."
  }

  validation {
    condition = alltrue([
      for record in var.records :
      record.proxied == true ? contains(["A", "AAAA", "CNAME"], upper(record.type)) : true
    ])
    error_message = "proxied=true is only allowed for A, AAAA, and CNAME records."
  }

  validation {
    condition = alltrue([
      for record in var.records :
      contains(["MX", "SRV", "URI"], upper(record.type)) ? record.priority != null : true
    ])
    error_message = "MX, SRV, and URI records require priority."
  }

  # CNAME은 같은 exact hostname에 다른 record와 공존 불가
  validation {
    condition = alltrue([
      for name in distinct([
        for record in var.records :
        lower(record.subdomain == "" ? "@" : trimsuffix(record.subdomain, "."))
      ]) :
      length([
        for record in var.records : record
        if lower(record.subdomain == "" ? "@" : trimsuffix(record.subdomain, ".")) == name
        && upper(record.type) == "CNAME"
      ]) == 0
      ||
      length([
        for record in var.records : record
        if lower(record.subdomain == "" ? "@" : trimsuffix(record.subdomain, ".")) == name
      ]) == 1
    ])
    error_message = "A CNAME record cannot coexist with any other record at the exact same name."
  }

  # 같은 name/type/priority/content 중복 방지
  validation {
    condition = length(flatten([
      for record in var.records : [
        for content in distinct(record.contents) :
        join("|", [
          lower(record.subdomain == "" ? "@" : trimsuffix(record.subdomain, ".")),
          upper(record.type),
          record.priority == null ? "" : tostring(record.priority),
          content
        ])
      ]
      ])) == length(distinct(flatten([
        for record in var.records : [
          for content in distinct(record.contents) :
          join("|", [
            lower(record.subdomain == "" ? "@" : trimsuffix(record.subdomain, ".")),
            upper(record.type),
            record.priority == null ? "" : tostring(record.priority),
            content
          ])
        ]
    ])))
    error_message = "Duplicate DNS records are not allowed. Each name/type/priority/content combination must be unique."
  }
}
