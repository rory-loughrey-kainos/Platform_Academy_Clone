# generate a certificate for alb using ACM
resource "aws_acm_certificate" "alb_cert" {
  domain_name       = aws_route53_record.alb_cname.fqdn
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# fulfill ACM DNS validation 
resource "aws_acm_certificate_validation" "alb_cert_validation" {
  certificate_arn         = aws_acm_certificate.alb_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_valid_cnames : record.fqdn]
}