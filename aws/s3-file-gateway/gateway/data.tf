data "aws_vpc" "this" {
  id = var.vpc.id
}

data "aws_vpc_endpoint" "storage_gateway_interface" {
  vpc_id       = var.vpc.id
  service_name = "com.amazonaws.ap-northeast-2.storagegateway"

  filter {
    name   = "vpc-endpoint-type"
    values = ["Interface"]
  }
}

data "aws_vpc_endpoint" "s3_gateway" {
  vpc_id       = var.vpc.id
  service_name = "com.amazonaws.ap-northeast-2.s3"

  filter {
    name   = "vpc-endpoint-type"
    values = ["Gateway"]
  }
}
