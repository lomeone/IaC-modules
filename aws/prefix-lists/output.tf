output "ids" {
  value       = { for k, v in aws_ec2_managed_prefix_list.main : k => v.id }
  description = "Map of prefix list name to prefix list ID"
}

output "arns" {
  value       = { for k, v in aws_ec2_managed_prefix_list.main : k => v.arn }
  description = "Map of prefix list name to prefix list ARN"
}
