resource "aws_instance" "storage_gateway" {
  ami           = "ami-01fd5b5ea8a90f2d0"
  instance_type = var.instance_type
  subnet_id     = var.vpc.gateway_instance_subnet

  associate_public_ip_address = true
  vpc_security_group_ids      = var.vpc.gateway_instance_security_groups

  root_block_device {
    volume_size = 80
    volume_type = "gp3"
    iops        = 3000
    throughput  = 125
  }

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = 150
    volume_type = "gp3"
    iops        = 3000
    throughput  = 125
  }

  key_name = aws_key_pair.storage_gateway.key_name

  tags = {
    Name = "${var.name}-storage-gateway-instance"
  }
}

resource "tls_private_key" "storage_gateway" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "storage_gateway" {
  key_name   = "${var.name}-storage-gateway-instance-key-pair"
  public_key = tls_private_key.storage_gateway.public_key_openssh
}
