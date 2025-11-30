variable "name" {
  type = object({
    eks = string
  })
  default = {
    eks = "default"
  }
  description = "resource name"
}

variable "vpc" {
  type = object({
    id                         = string
    name                       = string
    pod_custom_networking_cidr = string
    subnet_ids = object({
      control_plane         = list(string)
      node                  = list(string)
      pod_custom_networking = list(string)
    })
  })
  description = "vpc information"
}

variable "region" {
  type        = string
  default     = "ap-northeast-2"
  description = "service region"
}

variable "network" {
  type = object({
    service_ipv4_cidr = string
  })

  default = {
    service_ipv4_cidr = "172.20.0.0/16"
  }
}

variable "node_group" {
  type = object({
    node_instance_type = list(string)
    min_size           = number
    max_size           = number
    desired_size       = number
  })
  default = {
    node_instance_type = ["t4g.large"]
    min_size           = 1
    max_size           = 3
    desired_size       = 1
  }
}

variable "access_entries" {
  type = object({
    cluster_admins  = optional(list(string), [])
    cluster_viewers = optional(list(string), [])
  })

  default = {
    cluster_admins  = []
    cluster_viewers = []
  }
}
