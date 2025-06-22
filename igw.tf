// igw.tf: создание Internet Gateway 

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "k8s-igw"
  }
} 