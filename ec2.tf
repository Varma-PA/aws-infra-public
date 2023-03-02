data "aws_ami" "my_latest_ami" {
  # owners      = ["141894463187"]
  owners      = var.ami_owner_id
  most_recent = true
}



resource "aws_instance" "webapp-instance" {

  depends_on = [
    aws_db_instance.mysql_database
  ]

  ami = data.aws_ami.my_latest_ami.id

  instance_type = var.instance_type

  root_block_device {
    delete_on_termination = true
    volume_size           = var.volume_size
    volume_type           = var.volume_type
  }
  disable_api_termination = false


  vpc_security_group_ids = [aws_security_group.webapp_security_grip.id]

  # vpc_security_group_ids = ["sg-0b7a2684dac5465fd"]

  subnet_id = aws_subnet.public_1.id

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  # subnet_id = "subnet-0ba5c247599d6d5b1"

  # user_data = file("initialize-webapp.sh")

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

  sudo systemctl daemon-reload
  sudo systemctl enable nginx
  sudo systemctl start nginx
  sudo systemctl enable webapp
  sudo systemctl start webapp

  EOF

}

# resource "aws_instance" "my_ec2_instance" {

#     depends_on = [
#       aws_s3_bucket.my_s3_bucket
#     ]

#   ami = "ami-006dcf34c09e50022"

#   instance_type = "t2.micro"

# #   role = aws_iam_role.test_role.name

#     iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

#   tags = {
#     "Name" = "Hello World"
#   }

# }

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.EC2-CSYE6225.name
}

