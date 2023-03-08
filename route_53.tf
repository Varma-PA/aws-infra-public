resource "aws_route53_record" "myrecord" {
    depends_on = [
      aws_instance.webapp-instance
    ]
    name = var.route53_record_name
    zone_id = var.route53_zone_id
    type = "A"
    ttl = 300
    records = [aws_instance.webapp-instance.public_ip]
}

