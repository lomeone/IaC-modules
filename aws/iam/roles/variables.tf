variable "roles" {
  type = map(object({
    description = optional(string, "")
    trust_policy = object({
      principals = list(object({
        type        = string       # "Service", "AWS", "Federated"
        identifiers = list(string)
      }))
      actions = optional(list(string), ["sts:AssumeRole"])
      conditions = optional(list(object({
        test     = string
        variable = string
        values   = list(string)
      })), [])
    })
    managed_policy_arns = optional(list(string), [])
    inline_policy_statements = optional(list(object({
      sid       = optional(string, null)
      effect    = optional(string, "Allow")
      actions   = list(string)
      resources = list(string)
      conditions = optional(list(object({
        test     = string
        variable = string
        values   = list(string)
      })), [])
    })), [])
    max_session_duration = optional(number, 3600)
    tags                 = optional(map(string), {})
  }))
  description = "Map of IAM roles to create. Key is used as the role name."
}
