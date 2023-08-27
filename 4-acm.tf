#precisa configurar o próprio certificado, usamos o DNS para o método_validação
#resource "aws_acm_certificate" "cert" {
#  domain_name       = var.domain_name
#  validation_method = "DNS"
#  lifecycle {
#    create_before_destroy = true
#  }
#  depends_on = [aws_instance.wordpress_instance]
#}
#
##criar o registro CNAME de validação de DNS em nossa zona hospedada. 
#resource "aws_route53_record" "cert_validation_record" {
#  for_each = {
#    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
#      name   = dvo.resource_record_name
#      record = dvo.resource_record_value
#      type   = dvo.resource_record_type
#    }
#  }
#
#  allow_overwrite = true
#  name            = each.value.name
#  records         = [each.value.record]
#  ttl             = 60
#  type            = each.value.type
#  zone_id         = data.aws_route53_zone.this.zone_id
#
#  depends_on = [aws_instance.wordpress_instance]
#
#}
#
##processo de validação. A zona aws_route_53 já existe.
#resource "aws_acm_certificate_validation" "validation" {
#  timeouts {
#    create = "5m"
#  }
#  certificate_arn         = aws_acm_certificate.cert.arn
#  validation_record_fqdns = [for record in aws_route53_record.cert_validation_record : record.fqdn]
#
#  depends_on = [aws_instance.wordpress_instance]
#
#}
#
