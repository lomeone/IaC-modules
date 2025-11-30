# resource "aws_vpc_endpoint" "storage_gateway_interface" {
#   vpc_id             = var.vpc.id
#   service_name       = "com.amazonaws.ap-northeast-2.storagegateway"
#   vpc_endpoint_type  = "Interface"
#   subnet_ids         = var.subnet_ids.private
#   security_group_ids = [aws_security_group.storage_gateway_endpoint.id]

#   tags = {
#     Name = "${var.vpc.name}-storage-gateway-endpoint-interface"
#   }
# }

# resource "aws_security_group" "storage_gateway_endpoint" {
#   vpc_id = var.vpc.id
#   name   = "${var.vpc.name}-storage-gw-endpoint-sg"

#   tags = {
#     Name = "${var.vpc.name}-storage-gw-endpoint-sg"
#   }
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_https" {
#   security_group_id = aws_security_group.storage_gateway_endpoint.id
#   cidr_ipv4         = data.aws_vpc.this.cidr_block
#   from_port         = 443
#   to_port           = 443
#   ip_protocol       = "tcp"
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_storage_gateway_contol_port" {
#   security_group_id = aws_security_group.storage_gateway_endpoint.id
#   cidr_ipv4         = data.aws_vpc.this.cidr_block
#   from_port         = 1026
#   to_port           = 1028
#   ip_protocol       = "tcp"
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_storage_gateway_contol_port_sub" {
#   security_group_id = aws_security_group.storage_gateway_endpoint.id
#   cidr_ipv4         = data.aws_vpc.this.cidr_block
#   from_port         = 1031
#   to_port           = 1031
#   ip_protocol       = "tcp"
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_storage_gateway_metric" {
#   security_group_id = aws_security_group.storage_gateway_endpoint.id
#   cidr_ipv4         = data.aws_vpc.this.cidr_block
#   from_port         = 2222
#   to_port           = 2222
#   ip_protocol       = "tcp"
# }

# resource "aws_vpc_security_group_egress_rule" "allow_anywhere_s3_gw_endpoint" {
#   security_group_id = aws_security_group.storage_gateway_endpoint.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1"
# }
