// outputs.tf: outputs (например, IP адреса, ID ресурсов) 

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = aws_subnet.private[*].id
}

output "nat_instance_public_ip" {
  description = "Public IP of NAT instance"
  value       = aws_instance.nat.public_ip
}

output "nat_instance_private_ip" {
  description = "Private IP of NAT instance"
  value       = aws_instance.nat.private_ip
}

output "nat_network_interface_id" {
  description = "Network interface ID of NAT instance"
  value       = aws_network_interface.nat_instance.id
} 