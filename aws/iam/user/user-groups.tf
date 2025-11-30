resource "aws_iam_group" "main" {
  for_each = var.user_groups
  name     = each.key
}

resource "aws_iam_group_policy_attachment" "main" {
  for_each = { for idx, value in flatten([
    for group_name, group_data in var.user_groups :
    [
      for policy_arn in group_data.attachment_policy_arns :
      {
        group      = group_name
        policy_arn = policy_arn
      }
    ]
    ]) : idx => value
  }

  group      = each.value.group
  policy_arn = each.value.policy_arn
}
