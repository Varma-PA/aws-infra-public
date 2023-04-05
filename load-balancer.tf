
resource "aws_lb" "load_balancer" {

  name = "load-balancer-test"
  internal = false

  load_balancer_type = "application"

  security_groups = [aws_security_group.load_balancer_security_group.id]

  subnets = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id,
    aws_subnet.public_3.id
  ]

  tags = {
    "Name" = "Created by Terraform"
  }

}

resource "aws_lb_target_group" "target_group" {

  name = "csye6225-target-group"

  port = 80

  protocol = "HTTP"

  vpc_id = aws_vpc.main.id

  health_check {
    enabled = true
    path     = "/healthz"
    port     = 80
    interval = 300
    protocol = "HTTP"
  }


}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    forward {
      target_group {
        arn = aws_lb_target_group.target_group.arn
      }
      stickiness {
        enabled  = true
        duration = 28800
      }
    }
  }
}


# resource "aws_lb_target_group_attachment" "attachment_1" {
#   target_group_arn = aws_lb_target_group.target_group.arn
#   target_id        = aws_autoscaling_group.auto-scaling-group.arn
#   port             = 80
# }


# resource "aws_lb_listener" "load_balancer_listener" {



# }

