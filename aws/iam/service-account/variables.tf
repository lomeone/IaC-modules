variable "eks" {
  type = object({
    name     = string
    arn      = string
    oidc_arn = string
    oidc_url = string
  })
}

variable "region" {
  type        = string
  default     = "ap-northeast-2"
  description = "value of region"
}
