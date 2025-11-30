variable "name" {
  type        = string
  default     = "default"
  description = "resource name associated with the storage gateway"
}

variable "vpc" {
  type = object({
    id                               = string
    subnet_ids                       = list(string)
    gateway_instance_subnet          = string
    gateway_instance_security_groups = list(string)
    s3_endpoint_route_table_ids      = list(string)
  })
  description = "information abount vpc"
}

variable "instance_type" {
  type        = string
  default     = "t3.xlarge"
  description = "storage gateway instance type"
}
