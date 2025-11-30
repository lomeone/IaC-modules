variable "users" {
  type = map(object({
    groups         = list(string)
    access_key     = bool
    console_access = bool
  }))
}

variable "user_groups" {
  type = map(object({
    attachment_policy_arns = list(string)
  }))
}
