
resource "aws_storagegateway_nfs_file_share" "main" {
  client_list     = var.clients
  gateway_arn     = var.storage_gateway_arn
  location_arn    = "${var.s3.arn}/${var.s3.location}"
  role_arn        = aws_iam_role.s3_bucket_access.arn
  file_share_name = var.name

  cache_attributes {
    cache_stale_timeout_in_seconds = 300
  }
}
