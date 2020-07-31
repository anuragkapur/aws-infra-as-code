resource "aws_acm_certificate" "omwebedit_cert" {
  domain_name       = "omwebedit.${var.domain}"
  validation_method = "DNS"

  tags = {
    Environment = "prod"
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "zone" {
  name         = "${var.domain}."
  private_zone = false
}

resource "aws_route53_record" "cert_validation" {
  name    = aws_acm_certificate.omwebedit_cert.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.omwebedit_cert.domain_validation_options[0].resource_record_type
  zone_id = data.aws_route53_zone.zone.id
  records = [
    aws_acm_certificate.omwebedit_cert.domain_validation_options[0].resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.omwebedit_cert.arn
  validation_record_fqdns = [
    aws_route53_record.cert_validation.fqdn]
}