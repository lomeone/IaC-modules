variable "eks_clusters" {
  type = map(object({
    oidc_arn = string
    oidc_url = string
  }))
  description = "Map of EKS clusters providing OIDC info. Key is used as identifier."
}

variable "service_accounts" {
  type = map(object({
    description = optional(string, "")
    eks_bindings = map(list(object({  # key = eks_cluster key from eks_clusters
      namespace            = string
      service_account_name = string
    })))
    policy_arns = optional(list(string), [])
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
  description = "Map of IAM roles for EKS service accounts. Key is used as the role name."
}
