# Create public subnets
resource "aws_subnet" "public" {
  # count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_subnet
  availability_zone       = data.aws_availability_zones.available.names[0] # Use the first available AZ for the public subnet
  map_public_ip_on_launch = true
  tags                    = { Name = "devOps-public-subnet" }
}

# Create private subnets in the same availability zones as the public subnets
resource "aws_subnet" "private" {
  # count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pri_subnet
  availability_zone       = data.aws_availability_zones.available.names[0] # Use the first available AZ for the private subnet
  map_public_ip_on_launch = false
  tags                    = { Name = "devOps-private-subnet" }
}

# Create a DB subnet group for RDS using the private subnets
# resource "aws_db_subnet_group" "rds" {
#   name       = "${var.target_env}-rds-subnet-group"
#   subnet_ids = aws_subnet.private[*].id # Uses your private subnet IDs automatically

#   tags = { Name = "${var.target_env}-rds-subnet-group" }
# }
