variable "name" {
  type = string
}

variable "lifecycle_policies" {
  type = map(object({
    description = string
    selection   = string
    action      = string
  }))
  default = {}
}
