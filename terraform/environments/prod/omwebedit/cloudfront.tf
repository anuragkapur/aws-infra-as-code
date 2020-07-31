resource "aws_cloudfront_distribution" "s3_distribution" {
  provider = aws.useast1
  origin {
    domain_name = "${var.omwebedit_s3_bucket_name}.s3.amazonaws.com"
    origin_id = var.omwebedit_s3_bucket_name
  }

  enabled = true
  is_ipv6_enabled = true
  comment = "omwebedit"
  default_root_object = "index.html"

  aliases = [
    "omwebedit.${var.domain}"]

  default_cache_behavior {
    allowed_methods = [
      "DELETE",
      "GET",
      "HEAD",
      "OPTIONS",
      "PATCH",
      "POST",
      "PUT"]
    cached_methods = [
      "GET",
      "HEAD"]
    target_origin_id = var.omwebedit_s3_bucket_name

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl = 0
    default_ttl = 300
    max_ttl = 300
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.omwebedit_cert.arn
    ssl_support_method = "sni-only"
  }


  depends_on = [
    aws_acm_certificate.omwebedit_cert]
}