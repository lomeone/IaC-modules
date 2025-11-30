resource "aws_s3_bucket" "basic" {
  bucket = var.name.bucket
}

resource "aws_s3_bucket_versioning" "basic" {
  bucket = aws_s3_bucket.basic.id

  versioning_configuration {
    status = "Enabled"
  }
}
