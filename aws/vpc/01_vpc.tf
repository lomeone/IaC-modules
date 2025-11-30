resource "aws_vpc" "main" {
  cidr_block = var.cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.name.vpc}"
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "pod_custom_networking" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.pod_custom_networking_cidr
}
