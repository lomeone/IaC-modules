resource "aws_storagegateway_gateway" "this" {
  gateway_name         = var.name
  gateway_timezone     = "GMT+9:00"
  gateway_type         = "FILE_S3"
  gateway_ip_address   = aws_instance.storage_gateway.public_ip
  gateway_vpc_endpoint = data.aws_vpc_endpoint.storage_gateway_interface.dns_entry[0].dns_name

  depends_on = [data.aws_vpc_endpoint.s3_gateway]
}

data "aws_storagegateway_local_disk" "this" {
  gateway_arn = aws_storagegateway_gateway.this.arn
  disk_node   = "/dev/sdb"
}

resource "aws_storagegateway_cache" "this" {
  gateway_arn = aws_storagegateway_gateway.this.arn
  disk_id     = data.aws_storagegateway_local_disk.this.disk_id
}
