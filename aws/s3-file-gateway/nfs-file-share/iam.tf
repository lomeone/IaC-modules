resource "aws_iam_role" "s3_bucket_access" {
  name               = "${var.name}-StorageGatewayS3BucketAccessRole"
  assume_role_policy = data.aws_iam_policy_document.s3_bucket_access_assume_role.json
}

data "aws_iam_policy_document" "s3_bucket_access_assume_role" {
  version = "2012-10-17"

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["storagegateway.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "s3_bucket_access_S3AllowAceess" {
  role       = aws_iam_role.s3_bucket_access.name
  policy_arn = aws_iam_policy.s3_bucket_access_allow.arn
}

resource "aws_iam_policy" "s3_bucket_access_allow" {
  name   = "${aws_iam_role.s3_bucket_access.name}-policy"
  policy = data.aws_iam_policy_document.storagegateway_bucket_policy.json
}

data "aws_iam_policy_document" "storagegateway_bucket_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetAccelerateConfiguration",
      "s3:GetBucketLocation",
      "s3:GetBucketVersioning",
      "s3:ListBucket",
      "s3:ListBucketVersions",
      "s3:ListBucketMultipartUploads"
    ]
    resources = [var.s3.arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:AbortMultipartUpload",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectVersion",
      "s3:ListMultipartUploadParts",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    resources = ["${var.s3.arn}/${var.s3.location}*"]
  }
}
