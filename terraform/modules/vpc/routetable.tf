# Create a route table for public subnets
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devOps-igw.id
  }
  tags = { Name = "devOps-public-rt" }
}

resource "aws_route_table_association" "public" {
  # count          = 2
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public-rt.id
}

# aws route table - private
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "devOps-private-rt"
  }
}

resource "aws_route_table_association" "private" {
  # count          = 2
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.private-rt.id]
  tags              = { Name = "devOps-s3-endpoint" }
}