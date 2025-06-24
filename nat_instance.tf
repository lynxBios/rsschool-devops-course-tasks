// nat_instance.tf: NAT Instance (EC2 + user-data for NAT)

// Security group for NAT instance
resource "aws_security_group" "nat_instance" {
  name        = "nat-instance-sg"
  description = "Security group for NAT instance"
  vpc_id      = aws_vpc.main.id

  // Allow SSH access from specified IP
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

  // Allow all inbound traffic from VPC (for NAT)
  ingress {
    description = "All traffic from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  tags = {
    Name = "nat-instance-sg"
  }
}

// Network interface for NAT instance
resource "aws_network_interface" "nat_instance" {
  subnet_id         = aws_subnet.public[0].id
  security_groups   = [aws_security_group.nat_instance.id]
  source_dest_check = false // Required for NAT instance
  tags = {
    Name = "nat-instance-eni"
  }
}

// User data script for NAT configuration
data "template_file" "nat_user_data" {
  template = <<-EOF
#!/bin/bash
# Enable IP forwarding
echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
sysctl -p

# Configure iptables for NAT
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth0 -o eth0 -j ACCEPT

# Save iptables rules
iptables-save > /etc/iptables/rules.v4

# Install iptables-persistent to save rules on reboot
apt-get update
apt-get install -y iptables-persistent

# Create startup script to restore iptables rules
cat > /etc/rc.local << 'EOF2'
#!/bin/bash
iptables-restore < /etc/iptables/rules.v4
exit 0
EOF2
chmod +x /etc/rc.local
EOF
}

// NAT instance
resource "aws_instance" "nat" {
  ami           = var.ami_id
  instance_type = var.nat_instance_type
  key_name      = var.key_pair_name

  network_interface {
    network_interface_id = aws_network_interface.nat_instance.id
    device_index         = 0
  }

  user_data = data.template_file.nat_user_data.rendered

  tags = {
    Name = "k8s-nat-instance"
  }

  depends_on = [aws_network_interface.nat_instance]
} 