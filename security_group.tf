
resource "aws_security_group" "webapp_security_group" {

  name = "application"

  description = "This is the terraform security group"

  vpc_id = aws_vpc.main.id

  #   ingress = [
  #     {
  #       cidr_blocks = [aws_vpc.main.cidr_block]
  #       description = "Opening SSH to the world"
  #       from_port   = 22
  #       to_port     = 22
  #       protocol    = "tcp"
  #     },
  #     {
  #       cidr_blocks = [aws_vpc.main.cidr_block]
  #       description = "Opening HTTP to the world"
  #       from_port   = 80
  #       to_port     = 80
  #       protocol    = "tcp"
  #     },
  #     {
  #       cidr_blocks = [aws_vpc.main.cidr_block]
  #       description = "Opening HTTPS to the world"
  #       from_port   = 443
  #       to_port     = 443
  #       protocol    = "tcp"
  #     },
  #   ]

  # ingress {
  #   description = "SSH to EC2"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   # cidr_blocks = ["0.0.0.0/0"]
  #   # cidr_blocks = []
  #   security_groups = [aws_security_group.load_balancer_security_group.id]

  # }

  ingress {
    description = "Http to EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.load_balancer_security_group.id]
  }

  ingress {
    description = "Https to EC2"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    # cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.load_balancer_security_group.id]
  }
  # ingress {
  #   description = "Node App Port"
  #   from_port   = 3000
  #   to_port     = 3000
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_security_group" "database" {

  name = "database"

  description = "Used for database access"

  vpc_id = aws_vpc.main.id

  # ingress.0.protocol = 
  ingress {
    description = "Access To Database"
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    # cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.webapp_security_group.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_security_group" "load_balancer_security_group" {

  name = "load-balancer-security-group"

  description = "Security group for the load balancer"

  vpc_id = aws_vpc.main.id

  ingress {
    description = "Http to EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Https to EC2"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


}


