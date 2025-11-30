resource "aws_cloudfront_distribution" "main" {
  aliases = [var.domain]

  origin {
    domain_name = data.terraform_remote_state.ap-northeast-2.outputs.s3.website_configuration.website_endpoint
    origin_id   = "lomeone.s3.ap-northeast-2.amazonaws.com"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["SSLv3", "TLSv1.2", "TLSv1.1", "TLSv1"]
    }
  }

  enabled = true

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "lomeone.s3.ap-northeast-2.amazonaws.com"
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = data.terraform_remote_state.us-east-1.outputs.acm.cdn_acm_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  logging_config {
    bucket          = data.terraform_remote_state.ap-northeast-2.outputs.s3.domain_name.lomeone_log_bucket
    include_cookies = true
    prefix          = "cf_"
  }
}
