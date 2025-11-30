resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.name.vpc}-${var.name.public_route_table}"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "eks_control_plane" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_nat_gateway.id
  }

  tags = {
    Name = "${var.name.vpc}-${var.name.eks_control_plane_route_table}"
  }
}
resource "aws_route_table_association" "eks_control_plane" {
  count          = length(aws_subnet.eks_control_plane)
  subnet_id      = aws_subnet.eks_control_plane[count.index].id
  route_table_id = aws_route_table.eks_control_plane.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_nat_gateway.id
  }

  tags = {
    Name = "${var.name.vpc}-${var.name.private_route_table}"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table" "db_private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name.vpc}-${var.name.db_route_table}"
  }
}

resource "aws_route_table_association" "db_private" {
  count          = length(aws_subnet.db_private)
  subnet_id      = aws_subnet.db_private[count.index].id
  route_table_id = aws_route_table.db_private.id
}

resource "aws_route_table" "pod_custom_networking" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_nat_gateway.id
  }

  tags = {
    Name = "${var.name.vpc}-${var.name.pod_custom_networking_route_table}"
  }
}

resource "aws_route_table_association" "pod_custom_networking" {
  count          = length(aws_subnet.pod_custom_networking)
  subnet_id      = aws_subnet.pod_custom_networking[count.index].id
  route_table_id = aws_route_table.pod_custom_networking.id
}
