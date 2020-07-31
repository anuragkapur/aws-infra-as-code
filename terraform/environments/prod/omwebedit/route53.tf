resource "aws_route53_record" "omwebedit" {
  zone_id = data.aws_route53_zone.zone.id
  name    = "omwebedit.${var.domain}"
  type    = "A"

  alias {
    name                   = replace(aws_cloudfront_distribution.s3_distribution.domain_name, "/[.]$/", "")
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = true
  }

  depends_on = [aws_cloudfront_distribution.s3_distribution]
}