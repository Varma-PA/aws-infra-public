# variable "region" {
#   description = "AWS Deployment Region"
#   default     = "us-east-1"
# }

variable "ami_image" {
  default = "ami-09d56f8956ab235b3"
  type    = string
}

variable "profile" {
  default = "dev"
  type    = string
}

variable "region" {
  default = "us-east-1"
  type    = string
}


variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
  type    = string
}

variable "subnet_1_public_cidr" {
  default = "10.0.1.0/24"
  type    = string
}

variable "subnet_1_private_cidr" {
  default = "10.0.2.0/24"
  type    = string
}

variable "subnet_2_public_cidr" {
  default = "10.0.3.0/24"
  type    = string
}

variable "subnet_2_private_cidr" {
  default = "10.0.4.0/24"
  type    = string
}

variable "subnet_3_public_cidr" {
  default = "10.0.5.0/24"
  type    = string
}

variable "subnet_3_private_cidr" {
  default = "10.0.6.0/24"
  type    = string
}

variable "route_table_internet_gateway_cidr" {
  default = "0.0.0.0/0"
  type    = string
}


# variable "availability_zones" {
#   type = list(string)
#   # default     = ["us-east-1a", "us-east-1b"]
#   description = "Describing the values for availability zones"
# }


variable "ami_owner_id" {
  type    = list(string)
  default = ["141894463187"]
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}


variable "volume_size" {
  type    = number
  default = 50
}

variable "volume_type" {
  type    = string
  default = "gp2"
}


variable "db_allocated_storage" {
  type    = number
  default = 10
}

variable "db_name" {
  type    = string
  default = "csye6225"
}

variable "db_engine" {
  type    = string
  default = "mysql"
}

variable "engine_version" {
  type    = string
  default = "5.7"
}

variable "db_identifier" {
  type    = string
  default = "csye6225"
}


variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_username" {
  type    = string
  default = "csye6225"
}

variable "db_password" {
  type    = string
  default = "SomePassword!2022"
}

variable "db_storage_type" {
  type    = string
  default = "gp2"
}


variable "db_storage_encrypted" {
  type    = bool
  default = true
}

variable "db_skip_final_snapshot" {
  type    = bool
  default = true
}

variable "s3_bucket_prefix" {
  type    = string
  default = "s3-csye-6225-"
}

variable "db_port" {
  type    = number
  default = 3306
}


variable "route53_record_name" {
  type = string
}

# variable "route53_zone_id" {
#   type = string
# }
