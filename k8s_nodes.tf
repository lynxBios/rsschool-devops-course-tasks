resource "aws_instance" "k3s_master" {
  ami           = var.ami_id
  instance_type = "t4g.nano"
  key_name      = var.key_pair_name
  subnet_id     = aws_subnet.private[0].id
  vpc_security_group_ids = [aws_security_group.kubernetes_nodes.id]
  
  user_data = <<-EOF
    #!/bin/bash
    # Install k3s master
    curl -sfL https://get.k3s.io | sh -s - server --write-kubeconfig-mode 644
    # Wait for k3s to start and output the join token
    for i in {1..30}; do
      if [ -f /var/lib/rancher/k3s/server/node-token ]; then
        break
      fi
      sleep 2
    done
    # Print the join token to a file for debug
    cat /var/lib/rancher/k3s/server/node-token > /tmp/k3s_token.txt
  EOF

  tags = {
    Name = "k3s-master"
    Role = "k8s-master"
  }
}

resource "aws_instance" "k3s_agent" {
  ami           = var.ami_id
  instance_type = "t4g.nano"
  key_name      = var.key_pair_name
  subnet_id     = aws_subnet.private[1].id
  vpc_security_group_ids = [aws_security_group.kubernetes_nodes.id]

  user_data = <<-EOF
    #!/bin/bash
    MASTER_IP="${aws_instance.k3s_master.private_ip}"
    # Wait for master to be reachable
    for i in {1..30}; do
      ping -c 1 $MASTER_IP && break
      sleep 2
    done
    # Wait for the token file to be available on master
    for i in {1..30}; do
      ssh -o StrictHostKeyChecking=no -i /home/ec2-user/.ssh/authorized_keys ec2-user@$MASTER_IP 'test -f /var/lib/rancher/k3s/server/node-token' && break
      sleep 2
    done
    # Copy the join token from master
    scp -o StrictHostKeyChecking=no -i /home/ec2-user/.ssh/authorized_keys ec2-user@$MASTER_IP:/var/lib/rancher/k3s/server/node-token /tmp/k3s_token.txt
    TOKEN=$(cat /tmp/k3s_token.txt)
    # Install k3s agent
    curl -sfL https://get.k3s.io | K3S_URL="https://$MASTER_IP:6443" K3S_TOKEN="$TOKEN" sh -s - agent
  EOF

  tags = {
    Name = "k3s-agent"
    Role = "k8s-agent"
  }
}
 