resource "aws_iam_user" "main" {
  for_each = var.users
  name     = each.key
}

resource "aws_iam_access_key" "main" {
  for_each   = { for key, value in var.users : key => value if value.access_key }
  status     = "Active"
  user       = each.key
  depends_on = [aws_iam_user.main]
}

resource "aws_iam_user_login_profile" "main" {
  for_each                = { for key, value in var.users : key => value if value.console_access }
  user                    = each.key
  password_reset_required = true
  depends_on              = [aws_iam_user.main]
}

resource "aws_iam_user_policy_attachment" "main" {
  for_each   = { for key, value in var.users : key => value if value.console_access }
  user       = each.key
  policy_arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
  depends_on = [aws_iam_user.main]
}

resource "aws_iam_user_group_membership" "main" {
  for_each   = var.users
  groups     = each.value.groups
  user       = each.key
  depends_on = [aws_iam_user.main]
}
