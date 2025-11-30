resource "aws_acm_certificate" "this" {
  domain_name       = var.domain_name
  validation_method = "DNS"
  key_algorithm     = "RSA_2048"

  subject_alternative_names = var.san_domains

  lifecycle {
    create_before_destroy = true
  }
}
