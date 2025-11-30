resource "aws_iam_openid_connect_provider" "main" {
  url = var.oidc_url

  client_id_list = var.audiences

  thumbprint_list = var.thumbprint_list
}
