resource "aws_route53_zone" "main" {
  name = var.name

  comment = var.comment

  dynamic "vpc" {
    for_each = var.associate_vpc_id != null ? [var.associate_vpc_id] : []
    content {
      vpc_id = vpc.value
    }
  }
}
