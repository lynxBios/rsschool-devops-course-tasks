// variables.tf: all infrastructure variables

variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "eu-central-1"
}

variable "azs" {
  description = "List of Availability Zones to use"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "172.31.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["172.31.1.0/24", "172.31.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["172.31.101.0/24", "172.31.102.0/24"]
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "rsschool-devops"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "terraform_state_bucket" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
  default     = "tf-state-devops-2025q2"
}

variable "key_pair_name" {
  description = "Name of the EC2 key pair for SSH access"
  type        = string
  default     = "ec2-key-pair"
}

variable "ssh_access_ip" {
  description = "IP address allowed for SSH access to bastion and NAT instance"
  type        = string
  default     = "37.214.3.227/32"
}

variable "nat_instance_type" {
  description = "EC2 instance type for NAT instance"
  type        = string
  default     = "t3.nano"
}

variable "bastion_instance_type" {
  description = "EC2 instance type for bastion host"
  type        = string
  default     = "t3.micro"
}

// AMI ID for EC2 instances
variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0669b163befffbdfc" // Amazon Linux 2023 in eu-central-1
}
