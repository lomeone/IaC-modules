variable "pull_through_cache_rule" {
  type = object({
    repository_prefix     = string
    upstream_registry_url = string
  })
}

variable "secretsmanager_secret" {
  type = object({
    name        = string
    username    = string
    accessToken = string
    description = string
  })

  default = null
}
