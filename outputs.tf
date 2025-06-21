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

output "bastion_public_ip" {
  description = "Public IP of bastion host"
  value       = aws_instance.bastion.public_ip
}

output "bastion_private_ip" {
  description = "Private IP of bastion host"
  value       = aws_instance.bastion.private_ip
}

output "connection_instructions" {
  description = "Instructions for connecting to bastion host and private instances"
  value = <<-EOT
===========================================
   CONNECTION INSTRUCTIONS
===========================================

1. Connect to Bastion Host:
   ssh -i ec2-key-pair.pem ec2-user@${aws_instance.bastion.public_ip}

2. From Bastion Host, connect to NAT Instance:
   ssh -i ec2-key-pair.pem ec2-user@${aws_instance.nat.private_ip}

3. From Bastion Host, connect to any private instance:
   ssh -i ec2-key-pair.pem ec2-user@<private-instance-ip>

4. Direct connection to NAT Instance (if needed):
   ssh -i ec2-key-pair.pem ec2-user@${aws_instance.nat.public_ip}

===========================================
EOT
}

// Remove test instances outputs - they are no longer needed 