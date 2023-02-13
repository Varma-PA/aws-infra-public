resource "aws_internet_gateway" "ig_gateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "Created using Terraform"
  }
}