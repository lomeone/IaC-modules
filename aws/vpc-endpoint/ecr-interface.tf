# resource "aws_vpc_endpoint" "ecr_dkr" {
#   vpc_id            = var.vpc.id
#   service_name      = "com.amazonaws.ap-northeast-2.ecr.dkr"
#   vpc_endpoint_type = "Interface"

#   private_dns_enabled = true

#   subnet_ids         = var.subnet_ids.private
#   security_group_ids = var.security_group_ids.ecr-endpoint

#   tags = {
#     Name = "${var.vpc.name}-ecr-dkr-endpoint-interface"
#   }
# }

# resource "aws_vpc_endpoint" "ecr_api" {
#   vpc_id            = var.vpc.id
#   service_name      = "com.amazonaws.ap-northeast-2.ecr.api"
#   vpc_endpoint_type = "Interface"

#   private_dns_enabled = true

#   subnet_ids         = var.subnet_ids.private
#   security_group_ids = var.security_group_ids.ecr-endpoint

#   tags = {
#     Name = "${var.vpc.name}-ecr-api-endpoint-interface"
#   }
# }
