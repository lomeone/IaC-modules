output "users" {
  value = {
    for name, user in aws_iam_user.main : name => {
      password   = try(aws_iam_user_login_profile.main[name].password, null)
      access_key = try(aws_iam_access_key.main[name].id, null)
      secret     = try(aws_iam_access_key.main[name].secret, null)
    }
  }
}
