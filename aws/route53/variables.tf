variable "name" {
  type = string
}

variable "comment" {
  type    = string
  default = "Managed by Terraform"
}

variable "associate_vpc_id" {
  type    = string
  default = null
}

variable "records" {
  type = list(object({
    name    = string
    type    = string
    ttl     = number
    records = list(string)
  }))
  default = []
}

variable "aliases" {
  type = list(object({
    name                   = string,
    type                   = string,
    alias                  = string,
    zone_id                = string,
    evaluate_target_health = optional(bool, false)
  }))
  default = []
}
