resource "aws_route_table" "public_1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_gateway.id
  }

  tags = {
    "Name" = "Terraform route table public 1"
  }
}


resource "aws_route_table" "private_1" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "Terraform route table public 1"
  }
}


resource "aws_route_table_association" "public_1" {
  #   gateway_id     = aws_internet_gateway.ig_gateway.id

  depends_on = [
    aws_route_table.public_1,
    aws_subnet.public_1
  ]

  route_table_id = aws_route_table.public_1.id
  subnet_id      = aws_subnet.public_1.id
}

resource "aws_route_table_association" "public_2" {
  #   gateway_id     = aws_internet_gateway.ig_gateway.id

  depends_on = [
    aws_route_table.public_1,
    aws_subnet.public_2
  ]


  route_table_id = aws_route_table.public_1.id
  subnet_id      = aws_subnet.public_2.id
}

resource "aws_route_table_association" "public_3" {
  depends_on = [
    aws_route_table.public_1,
    aws_subnet.public_3
  ]



  route_table_id = aws_route_table.public_1.id
  subnet_id      = aws_subnet.public_3.id
}


# resource "aws_route_table_association" "public_3" {
#   #   gateway_id     = aws_internet_gateway.ig_gateway.id
#   route_table_id = aws_route_table.public_1.id
#   subnet_id      = aws_subnet.public_3.id
# }


resource "aws_route_table_association" "private_1" {

  depends_on = [
    aws_route_table.private_1,
    aws_subnet.private_1
  ]


  route_table_id = aws_route_table.private_1.id
  subnet_id      = aws_subnet.private_1.id
}

resource "aws_route_table_association" "private_2" {

  depends_on = [
    aws_route_table.private_1,
    aws_subnet.private_2
  ]


  route_table_id = aws_route_table.private_1.id
  subnet_id      = aws_subnet.private_2.id
}

resource "aws_route_table_association" "private_3" {

  depends_on = [
    aws_route_table.private_1,
    aws_subnet.private_3
  ]


  route_table_id = aws_route_table.private_1.id
  subnet_id      = aws_subnet.private_3.id
}
