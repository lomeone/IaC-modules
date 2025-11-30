data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  az = data.aws_availability_zones.available.names
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  count  = length(var.subnet_cidr.public)

  cidr_block        = var.subnet_cidr.public[count.index]
  availability_zone = local.az[count.index % var.availability_zone_count]

  map_public_ip_on_launch = true

  tags = {
    "kubernetes.io/role/elb" = 1
    Name                     = "${var.name.vpc}-${var.name.public_subnet}-${format("%02s", count.index)}-${local.az[count.index % var.availability_zone_count]}"
  }
}

resource "aws_subnet" "eks_control_plane" {
  vpc_id = aws_vpc.main.id
  count  = length(var.subnet_cidr.eks_control_plane)

  cidr_block        = var.subnet_cidr.eks_control_plane[count.index]
  availability_zone = local.az[count.index % var.availability_zone_count]

  tags = {
    Name = "${var.name.vpc}-${var.name.eks_control_plane_subnet}-${format("%02s", count.index)}-${local.az[count.index % var.availability_zone_count]}"
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  count  = length(var.subnet_cidr.private)

  cidr_block        = var.subnet_cidr.private[count.index]
  availability_zone = local.az[count.index % var.availability_zone_count]

  tags = {
    "kubernetes.io/role/interna-elb" = 1
    "karpenter.sh/discovery"         = var.name.eks
    Name                             = "${var.name.vpc}-${var.name.private_subnet}-${format("%02s", count.index)}-${local.az[count.index % var.availability_zone_count]}"
  }
}

resource "aws_subnet" "db_private" {
  vpc_id = aws_vpc.main.id
  count  = length(var.subnet_cidr.db_private)

  cidr_block        = var.subnet_cidr.db_private[count.index]
  availability_zone = local.az[count.index % var.availability_zone_count]

  tags = {
    Name = "${var.name.vpc}-${var.name.db_private_subnet}-${format("%02s", count.index)}-${local.az[count.index % var.availability_zone_count]}"
  }
}

resource "aws_subnet" "pod_custom_networking" {
  vpc_id = aws_vpc.main.id
  count  = length(var.subnet_cidr.pod_custom_networking)

  cidr_block        = var.subnet_cidr.pod_custom_networking[count.index]
  availability_zone = local.az[count.index % var.availability_zone_count]

  tags = {
    Name = "${var.name.vpc}-${var.name.pod_custom_networking_subnet}-${format("%02s", count.index)}-${local.az[count.index % var.availability_zone_count]}"
  }

  depends_on = [aws_vpc_ipv4_cidr_block_association.pod_custom_networking]
}
