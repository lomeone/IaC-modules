variable "name" {
  type = object({
    bucket = string
  })
  description = "s3 resource name"
}
