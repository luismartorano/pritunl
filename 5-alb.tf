# Instance Target Group
#resource "aws_lb_target_group" "tg" {
#  name        = var.alb_tg_name
#  port        = 80
#  protocol    = "HTTP"
#  target_type = "instance"
#
#  vpc_id = module.vpc.vpc_id
#  health_check {
#    healthy_threshold   = 5
#    unhealthy_threshold = 2
#    timeout             = 5
#    interval            = 30
#  }
#
#  depends_on = [aws_instance.wordpress_instance, aws_acm_certificate.cert]
#
#}
#
## Cria alb
#resource "aws_alb" "wordpresslb" {
#  name                       = var.alb_alb_name
#  internal                   = false
#  load_balancer_type         = "application"
#  enable_deletion_protection = false
#
#  subnets         = module.vpc.public_subnets[*]
#  security_groups = [aws_security_group.bitnami_wordpress_lb_sg.id]
#
#  depends_on = [aws_instance.wordpress_instance, aws_acm_certificate.cert]
#
#}
#
#
## Cria os listeners e regras
#resource "aws_lb_listener" "wordpresslb_https" {
#  load_balancer_arn = aws_alb.wordpresslb.arn
#  port              = "443"
#  protocol          = "HTTPS"
#  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
#  certificate_arn   = aws_acm_certificate.cert.arn
#
#  default_action {
#    type             = "forward"
#    target_group_arn = aws_lb_target_group.tg.arn
#  }
#  depends_on = [aws_instance.wordpress_instance, aws_acm_certificate.cert]
#
#}
#
#resource "aws_alb_target_group_attachment" "tgattachment" {
#
#  target_group_arn = aws_lb_target_group.tg.arn
#  target_id        = aws_instance.wordpress_instance.id
#  port             = 80
#
#  depends_on = [aws_lb_target_group.tg, aws_instance.wordpress_instance, aws_acm_certificate.cert]
#
#}
#
#
#
#
#
