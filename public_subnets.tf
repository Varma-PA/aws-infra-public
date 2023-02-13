resource "aws_subnet" "public_1" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.subnet_1_public_cidr

  availability_zone = var.availability_zones[0]

  tags = {
    "Name" = "Terraform Public Subnet 1"
  }

}


resource "aws_subnet" "public_2" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.subnet_2_public_cidr

  availability_zone = var.availability_zones[1]

  tags = {
    "Name" = "Terraform Public Subnet 2"
  }

}

resource "aws_subnet" "public_3" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.subnet_3_public_cidr


  availability_zone = var.availability_zones[2]

  tags = {
    "Name" = "Terraform Public Subnet 3"
  }

}

