data "aws_ami" "my_latest_ami" {
  # owners      = ["141894463187"]
  owners = var.ami_owner_id
  most_recent = true
}



resource "aws_instance" "webapp-instance" {

  ami = data.aws_ami.my_latest_ami.id

  instance_type = var.instance_type

  root_block_device {
    delete_on_termination = true
    volume_size = var.volume_size
    volume_type = var.volume_type
  }
  disable_api_termination = false


  vpc_security_group_ids = [aws_security_group.webapp_security_grip.id]

  subnet_id = aws_subnet.public_1.id

  user_data = file("initialize-webapp.sh")

}
