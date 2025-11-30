variable "name" {
  type    = string
  default = "default"
}

variable "storage_gateway_arn" {
  type        = string
  description = "storage gateway arn"
}

variable "s3" {
  type = object({
    arn      = string
    location = string
  })
  description = <<EOT
  information about s3 that for shared
  arn: s3 arn
  location: s3 directory location. You have to end with a '/'
  EOT
}

variable "clients" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = "cilent list can access"
}
