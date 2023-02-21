data "aws_ami" "my_latest_ami" {
  owners      = ["141894463187"]
  most_recent = true
}



resource "aws_instance" "webapp-instance" {

  ami = data.aws_ami.my_latest_ami.id

  instance_type = "t2.micro"

  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }

  vpc_security_group_ids = [aws_security_group.webapp_security_grip.id]

  subnet_id = aws_subnet.public_1.id

  user_data = file("initialize-webapp.sh")

}
