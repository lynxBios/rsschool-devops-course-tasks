// bastion.tf: Bastion Host (EC2 for SSH access)

// Security group for bastion host
resource "aws_security_group" "bastion" {
  name        = "bastion-sg"
  description = "Security group for bastion host"
  vpc_id      = aws_vpc.main.id

  // Allow SSH access only from specified IP
  ingress {
    description = "SSH from specified IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_access_ip]
  }

  // Allow all outbound traffic
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}

// Bastion host instance
resource "aws_instance" "bastion" {
  ami           = "ami-0669b163befffbdfc" // Amazon Linux 2023
  instance_type = var.bastion_instance_type
  key_name      = var.key_pair_name
  subnet_id     = aws_subnet.public[0].id

  vpc_security_group_ids = [aws_security_group.bastion.id]

  // User data to install and configure SSH
  user_data = <<-EOF
#!/bin/bash
# Update system
yum update -y

# Install additional tools
yum install -y curl wget git

# Configure SSH for better security
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd

# Create welcome message
cat > /etc/motd << 'MOTD'
===========================================
   BASTION HOST - K8s Infrastructure
===========================================
This is a bastion host for secure access to private instances.
Use this host to SSH into instances in private subnets.

Available private instances:
- NAT Instance: 172.31.1.188
- Private Subnet 1: 172.31.101.0/24
- Private Subnet 2: 172.31.102.0/24

Example: ssh -i key.pem ec2-user@172.31.1.188
===========================================
MOTD
EOF

  tags = {
    Name = "k8s-bastion-host"
  }
} 