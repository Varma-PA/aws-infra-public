resource "aws_launch_configuration" "auto_scaling_launch_configuration" {

  name = "asg_launch_configuration"

  instance_type = "t2.micro"

  image_id = data.aws_ami.my_latest_ami.id

  key_name = "AWS_DEV_MACBOOK_PRO"

  associate_public_ip_address = true

  #   security_groups = [aws_security_group.webapp_security_group.id]

  security_groups = [aws_security_group.webapp_security_group.id]

  # vpc_classic_link_id = aws_vpc.main.id

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name


  user_data = <<EOF
    #!/bin/bash
    cd /home/ec2-user
    touch .env
    echo DB_DATABASE="${aws_db_instance.mysql_database.db_name}" >> .env
    echo DB_USERNAME="${aws_db_instance.mysql_database.username}" >> .env
    echo DB_PASSWORD="${aws_db_instance.mysql_database.password}" >> .env
    echo DB_HOST="${aws_db_instance.mysql_database.address}" >> .env
    echo PORT="3002" >> .env
    echo AWS_S3_BUCKET_NAME="${aws_s3_bucket.my_s3_bucket.bucket}" >> .env
    echo NODE_ENV="production" >> .env  

    sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
        -a fetch-config \
        -m ec2 \
        -c file:/home/ec2-user/cloud-watch-config.json \
        -s

    sudo systemctl daemon-reload
    sudo systemctl enable nginx
    sudo systemctl start nginx
    sudo systemctl enable webapp
    sudo systemctl start webapp



    EOF

}