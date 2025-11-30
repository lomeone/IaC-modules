output "storage_gateway" {
  value = {
    gateway_arn = aws_storagegateway_gateway.this.arn
  }
}

output "gateway_instance_private_key_pem" {
  value     = tls_private_key.storage_gateway.private_key_pem
  sensitive = true
}

output "gateway_instance_public_key_openssh" {
  value = tls_private_key.storage_gateway.public_key_openssh
}
