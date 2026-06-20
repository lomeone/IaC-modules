variable "prefix_lists" {
  type = map(object({
    description    = string
    address_family = string
    max_entries    = number
    entries = list(string)
    tags = optional(map(string), {})
  }))

  validation {
    condition = alltrue([
      for v in values(var.prefix_lists) : contains(["IPv4", "IPv6"], v.address_family)
    ])
    error_message = "address_family must be either 'IPv4' or 'IPv6'."
  }
}
