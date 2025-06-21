// route_tables.tf: route tables and associations

// Public route table - allows instances to reach internet via IGW
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "k8s-public-rt"
    Type = "public"
  }
}

// Route to internet for public subnets
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

// Associate public route table with public subnets
resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

// Private route table - will route through NAT instance
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "k8s-private-rt"
    Type = "private"
  }
}

// Route to internet for private subnets via NAT instance
// This will be added after NAT instance is created
resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_network_interface.nat_instance.id
  depends_on             = [aws_network_interface.nat_instance]
}

// Associate private route table with private subnets
resource "aws_route_table_association" "private" {
  count          = 2
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
} 