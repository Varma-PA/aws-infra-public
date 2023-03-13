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


ami_owner_id  = ["141894463187"]
instance_type = "t2.micro"
volume_size   = 50
volume_type   = "gp2"

# Database Var files
db_allocated_storage = 10
# db_name = 
db_engine = "mysql"
engine_version = "5.7"
db_identifier = "csye6225"
db_instance_class = "db.t3.micro"
# db_username = 
# db_password = 
db_storage_type = "gp2"
db_storage_encrypted = true
db_skip_final_snapshot = true


s3_bucket_prefix = "s3-csye-6225-"

db_port = 3306

# Route 53
route53_record_name = "dev.achyuthvarma.me"
# route53_zone_id = "Z0222018174B4GTBCUTWS"