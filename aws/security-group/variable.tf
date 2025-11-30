variable "vpc" {
  type = object({
    id   = string,
    name = string
  })
  default = {
    id   = "",
    name = ""
  }
  description = "VPC to create security group in"
}

variable "security_group_info" {
  type = object({
    name        = string,
    description = string,
    tags        = map(string)
    ingress = list(object({
      protocol          = string,
      from_port         = number,
      to_port           = number,
      cidr_block_v4     = optional(string, null),
      cidr_block_v6     = optional(string, null),
      security_group_id = optional(string, null)
      prefix_list_id    = optional(string, null)
    })),
    egress = list(object({
      protocol          = optional(string, "-1"),
      from_port         = optional(number, "-1"),
      to_port           = optional(number, "-1"),
      cidr_block_v4     = optional(string, null)
      cidr_block_v6     = optional(string, null)
      security_group_id = optional(string, null)
      prefix_list_id    = optional(string, null)
    }))
  })
}
