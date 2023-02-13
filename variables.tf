# variable "region" {
#   description = "AWS Deployment Region"
#   default     = "us-east-1"
# }

variable "ami_image" {
  default = "ami-09d56f8956ab235b3"
  type    = string
}

variable "profile"{
  default = "dev"
  type = string
}

variable "region" {
  default = "us-east-1"
  type = string
}


variable "vpc_cidr_block"{
  default = "10.0.0.0/16"
  type = string
}

variable "subnet_1_public_cidr" {
  default = "10.0.1.0/24"
  type = string
}

variable "subnet_1_private_cidr" {
  default = "10.0.2.0/24"
  type = string
}

variable "subnet_2_public_cidr" {
  default = "10.0.3.0/24"
  type = string
}

variable "subnet_2_private_cidr" {
  default = "10.0.4.0/24"
  type = string
}

variable "subnet_3_public_cidr" {
  default = "10.0.5.0/24"
  type = string
}

variable "subnet_3_private_cidr" {
  default = "10.0.6.0/24"
  type = string
}


variable "availability_zones" {
  type        = list(string)
  # default     = ["us-east-1a", "us-east-1b"]
  description = "Describing the values for availability zones"
}