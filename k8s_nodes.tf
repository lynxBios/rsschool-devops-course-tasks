resource "aws_instance" "k3s_master" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = var.key_pair_name
  subnet_id     = aws_subnet.private[0].id
  vpc_security_group_ids = [aws_security_group.kubernetes_nodes.id]
  tags = {
    Name = "k3s-master"
    Role = "k8s-master"
  }
}

resource "aws_instance" "k3s_agent" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = var.key_pair_name
  subnet_id     = aws_subnet.private[1].id
  vpc_security_group_ids = [aws_security_group.kubernetes_nodes.id]
  tags = {
    Name = "k3s-agent"
    Role = "k8s-agent"
  }
}
 