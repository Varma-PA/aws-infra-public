profile = "dev"
region  = "us-east-1"

route_table_internet_gateway_cidr = "0.0.0.0/0"

vpc_cidr_block = "10.0.0.0/16"

subnet_1_public_cidr  = "10.0.1.0/24"
subnet_1_private_cidr = "10.0.2.0/24"

subnet_2_public_cidr  = "10.0.3.0/24"
subnet_2_private_cidr = "10.0.4.0/24"

subnet_3_public_cidr  = "10.0.5.0/24"
subnet_3_private_cidr = "10.0.6.0/24"


ami_owner_id = ["141894463187"]
instance_type = "t2.micro"
volume_size = 50
volume_type = "gp2"
