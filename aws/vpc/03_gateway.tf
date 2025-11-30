resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name.vpc}-${var.name.internet_gateway}"
  }
}

resource "aws_eip" "nat_gateway_eip" {
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "public_nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.public[0].id
  depends_on    = [aws_internet_gateway.igw]

  tags = {
    Name = "${var.name.vpc}-${var.name.public_nat_gateway}"
  }
}
