output "service_accounts" {
  value = {
    for name, role in aws_iam_role.main : name => {
      arn       = role.arn
      name      = role.name
      id        = role.id
      unique_id = role.unique_id
    }
  }
  description = "Map of created IAM roles for service accounts. Key matches input service account role name."
}
