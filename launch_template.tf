resource "aws_launch_template" "launch_template" {

  name = "launch_template_csye"


  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 20
    }

  }

  image_id = data.aws_ami.my_latest_ami.id

  key_name = "AWS_DEV_MACBOOK_PRO"

  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.webapp_security_group.id]

  # iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  iam_instance_profile {
    arn = aws_iam_instance_profile.ec2_profile.arn
  }

  user_data = base64encode(templatefile("./auto-scaling-launch-template.sh",
    {
      db_name          = aws_db_instance.mysql_database.db_name,
      username         = aws_db_instance.mysql_database.username,
      password         = aws_db_instance.mysql_database.password,
      database_address = aws_db_instance.mysql_database.address,
      s3_bucket        = aws_s3_bucket.my_s3_bucket.bucket
    }
  ))
}