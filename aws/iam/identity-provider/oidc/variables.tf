variable "oidc_url" {
  type        = string
  description = "The URL of the OIDC identity provider."
}

variable "audiences" {
  type        = list(string)
  description = "A list of client IDs that are associated with this identity provider."
}

variable "thumbprint_list" {
  type        = list(string)
  description = "A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server."
}
