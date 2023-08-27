#resource "aws_route53_record" "wordpress_lb_dns" {
#  name    = var.domain_name
#  type    = "A"
#  zone_id = data.aws_route53_zone.this.zone_id
#
#  alias {
#    name                   = aws_alb.wordpresslb.dns_name
#    zone_id                = aws_alb.wordpresslb.zone_id
#    evaluate_target_health = true
#  }
#}
#
