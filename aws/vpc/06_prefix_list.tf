# resource "aws_ec2_managed_prefix_list" "vpc_private_subnet" {
#   name           = "vpc-private-subnet"
#   address_family = "IPv4"
#   max_entries    = 3
# }

# resource "aws_ec2_managed_prefix_list_entry" "vpc_private_subnet" {
#   count = length(aws_subnet.private)

#   prefix_list_id = aws_ec2_managed_prefix_list.vpc_private_subnet.id

#   cidr = aws_subnet.private[count.index].cidr_block
# }
