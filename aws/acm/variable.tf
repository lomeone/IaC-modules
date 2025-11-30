variable "domain_name" {
  type        = string
  description = "value of domain name"
}

variable "san_domains" {
  type        = list(string)
  description = "value of domain names"
}
