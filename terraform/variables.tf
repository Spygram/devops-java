variable "aws_region" { default = "us-east-1" } # This variable is used in provider.tf and main.tf
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "public_subnet" { default = "10.0.1.0/24" }
variable "private_subnet" { default = "10.0.2.0/24" }
variable "instance_type" { default = "t2.micro" }