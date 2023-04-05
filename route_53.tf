data "aws_route53_zone" "selected" {
  name = var.route53_record_name
}

resource "aws_route53_record" "myrecord" {
  # depends_on = [
  #   aws_instance.webapp-instance
  # ]
  name    = var.route53_record_name
  zone_id = data.aws_route53_zone.selected.zone_id
  # zone_id = var.route53_zone_id
  type = "A"

  # records = [aws_instance.webapp-instance.public_ip]

  # ttl  = 60
  alias {
    name                   = aws_lb.load_balancer.dns_name
    zone_id                = aws_lb.load_balancer.zone_id
    evaluate_target_health = true
  }


}

