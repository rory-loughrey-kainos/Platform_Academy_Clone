data "aws_route53_zone" "platform_public_dns" {
  name         = "kainos-platform-academy.com"
  private_zone = false
}

resource "aws_route53_record" "alb_dns_record" {
  zone_id = data.aws_route53_zone.platform_public_dns.zone_id
  name    = "${aws_lb.alb.name}.${data.aws_route53_zone.platform_public_dns.name}"
  type    = "A"

  alias {
    name                   = "dualstack.${aws_lb.alb.dns_name}"
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_zone" "private" {
  name = "rory-dns.com"

  vpc {
    vpc_id = aws_vpc.vpc-rory.id
  }
}

//cert record
resource "aws_route53_record" "alb_cert_ssl_record" {
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
  zone_id         = data.aws_route53_zone.platform_public_dns.zone_id
}

//priv
resource "aws_route53_record" "db_record" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "rory-db.com"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_db_instance.postgres.address]
}


