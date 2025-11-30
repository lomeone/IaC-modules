variable "name" {
  type = object({
    db_cluster = string
    db         = string
  })
  default = {
    db_cluster = "default-db-cluster"
    db         = "default"
  }
  description = "db clster identifier"
}

variable "vpc" {
  type = object({
    db_subnet_ids   = list(string)
    db_subnet_group = string
    security_groups = list(string)
  })
  description = "vpc info"
}

variable "db_info" {
  type = object({
    admin_username = string
    instance_type  = string
  })
  default = {
    admin_username = "admin"
    instance_type  = "db.t4g.medium"
  }
  description = "database info"
}
