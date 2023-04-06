# resource "aws_launch_template" "launch_template" {

#   name = "AWS-Launch-Template"

#   block_device_mappings {
#     device_name = "/dev/sdf"

#     ebs {
#       volume_size = 20
#     }
#   }

#   image_id = aws_instance.webapp-instance.ami

#   instance_type = "t2.micro"

#   instance_initiated_shutdown_behavior = "terminate"

#   vpc_security_group_ids = [aws_security_group.webapp_security_group.id]

#   user_data = base64encode(templatefile("./auto-scaling-launch-template.sh", {
#     db_name          = aws_db_instance.mysql_database.db_name,
#     username         = aws_db_instance.mysql_database.username,
#     password         = aws_db_instance.mysql_database.password,
#     database_address = aws_db_instance.mysql_database.address,
#     s3_bucket        = aws_s3_bucket.my_s3_bucket.bucket
#     }
#   ))
# }


resource "aws_autoscaling_group" "auto-scaling-group" {

  #   depends_on = [
  #     aws_lb.load_balancer
  #   ]  

  #   availability_zones = [for name in data.aws_availability_zones.available.names : name]

  desired_capacity = 1

  max_size = 3

  min_size = 1

  # launch_configuration = aws_launch_configuration.auto_scaling_launch_configuration.name

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  default_cooldown = 60

  force_delete = true

  target_group_arns = [aws_lb_target_group.target_group.arn]

  vpc_zone_identifier = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id,
    aws_subnet.public_3.id
  ]

    # load_balancers = [
    #   aws_lb.load_balancer.id
    # ]

  tag {
    key                 = "Name"
    value               = "CSYE6225-WebApp"
    propagate_at_launch = true
  }
}

# resource "aws_autoscaling_policy" "as_policy" {

#   name = "auto_scaling_policy"

#   policy_type = "TargetTrackingScaling"

#   autoscaling_group_name = aws_autoscaling_group.auto-scaling-group.name

#   # adjustment_type = "ChangeInCapacity"

#   target_tracking_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ASGAverageCPUUtilization"

#     }
#     target_value = 5.0
#   }

#   # cooldown = 10

  

# }

resource "aws_autoscaling_policy" "custom_scaling_policy_scale_up" {

  name = "custom-csye-policy-scale-up"

  autoscaling_group_name = aws_autoscaling_group.auto-scaling-group.name

  adjustment_type = "ChangeInCapacity"

  scaling_adjustment = 1

  cooldown = 10

  policy_type = "SimpleScaling"

}

resource "aws_cloudwatch_metric_alarm" "average-cpu-alarm-increase" {
  alarm_name = "average-cpu-alarm-scaleup"

  alarm_description = "Alarm Once average cpu usage increases"

  comparison_operator = "GreaterThanOrEqualToThreshold"

  evaluation_periods = 2

  metric_name = "CPUUtilization"

  namespace = "AWS/EC2"

  period = 120

  statistic = "Average"

  threshold = 5

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.auto-scaling-group.name
  }

  alarm_actions = [aws_autoscaling_policy.custom_scaling_policy_scale_up.arn]


}

resource "aws_autoscaling_policy" "custom_scaling_policy_scale_down" {

  name = "custom-csye-policy-scale-down"

  autoscaling_group_name = aws_autoscaling_group.auto-scaling-group.name

  adjustment_type = "ChangeInCapacity"

  scaling_adjustment = -1

  cooldown = 10

  policy_type = "SimpleScaling"

}

resource "aws_cloudwatch_metric_alarm" "average-cpu-alarm-decrease" {
  alarm_name = "average-cpu-alarm-scaledown"

  alarm_description = "Alarm Once average cpu usage increases"

  comparison_operator = "LessThanThreshold"

  evaluation_periods = 2

  metric_name = "CPUUtilization"

  namespace = "AWS/EC2"

  period = 120

  statistic = "Average"

  threshold = 3

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.auto-scaling-group.name
  }

  alarm_actions = [aws_autoscaling_policy.custom_scaling_policy_scale_down.arn]


}



# resource "aws_autoscaling_policy" "scaling_up" {

#   name = "auto_scaling_policy_up"

#   policy_type = "TargetTrackingScaling"


#   autoscaling_group_name = aws_autoscaling_group.auto-scaling-group.name

#   adjustment_type = "ChangeInCapacity"

#   scaling_adjustment = 1


# }



resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.auto-scaling-group.id
  lb_target_group_arn    = aws_lb_target_group.target_group.arn
}


