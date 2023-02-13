resource "aws_subnet" "private_1" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.subnet_1_private_cidr

#   availability_zone = var.availability_zones[0]

  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    "Name" = "Terraform Private Subnet 1"
  }

}


resource "aws_subnet" "private_2" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.subnet_2_private_cidr

#   availability_zone = var.availability_zones[1]

  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    "Name" = "Terraform Private Subnet 2"
  }

}

resource "aws_subnet" "private_3" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.subnet_3_private_cidr


#   availability_zone = var.availability_zones[2]

  availability_zone = data.aws_availability_zones.available.names[2]

  tags = {
    "Name" = "Terraform Private Subnet 3"
  }

}