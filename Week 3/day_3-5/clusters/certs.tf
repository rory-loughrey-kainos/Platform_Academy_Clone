resource "aws_acm_certificate" "alb_cert" {

  domain_name = "${aws_lb.alb.name}.${data.aws_route53_zone.platform_public_dns.name}"

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "alb-certificate${var.root-name}"
  }
}

resource "aws_acm_certificate_validation" "verify_alb_cert" {
  certificate_arn         = aws_acm_certificate.alb_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.alb_cert_ssl_record : record.fqdn]
}

