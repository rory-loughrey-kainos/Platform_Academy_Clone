# create the dns zone
data "aws_route53_zone" "d63_co_uk" {
   #name = "d63a8c22cfb9.co.uk."
    zone_id = "Z05223301U5YNZ7I2NKFT"
}

# add cname record for the load balancer on the wacky domain
resource "aws_route53_record" "alb_cname" {
    zone_id = data.aws_route53_zone.d63_co_uk.zone_id
    name = "bradt"
    type = "CNAME"
    ttl = "60"
    records = [aws_lb.alb_main.dns_name]
}

# add the ACM cname records for ACM validation
resource "aws_route53_record" "acm_valid_cnames" {
  depends_on = [aws_acm_certificate.alb_cert]

  for_each = {
    for dvo in aws_acm_certificate.alb_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.d63_co_uk.zone_id
}

# output "service_fqdn" {
#     value = aws_route53_record.cname.fqdn
# }