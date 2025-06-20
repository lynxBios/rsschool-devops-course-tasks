# RSSchool DevOps Course Tasks

## AWS DevOps 2025Q2

### Project Description
This repository contains infrastructure as code (IaC) for AWS resources using Terraform. The infrastructure includes:
- S3 bucket for Terraform state storage
- IAM roles and policies for GitHub Actions
- Other AWS resources as needed

### Prerequisites
- AWS CLI 2.x
- Terraform 1.6+
- AWS Account with appropriate permissions
- GitHub Account

### Infrastructure Setup
1. Configure AWS CLI with your credentials
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Plan the infrastructure:
   ```bash
   terraform plan
   ```
4. Apply the infrastructure:
   ```bash
   terraform apply
   ```

### Project Structure
- `main.tf` - Main Terraform configuration
- `variables.tf` - Variable definitions
- `providers.tf` - Provider configurations
- `backend.tf` - Backend configuration for state storage
- `.github/workflows/` - GitHub Actions workflows

### Security
- S3 bucket for Terraform state is encrypted
- Public access is blocked
- Versioning is enabled
- IAM roles follow least privilege principle

### Contributing
1. Create a new branch
2. Make your changes
3. Create a pull request
4. Ensure all checks pass

## New Terraform File Structure (Cheaper way: NAT Instance)

- `vpc.tf` — VPC and basic resources
- `subnets.tf` — public and private subnets in two AZs
- `igw.tf` — Internet Gateway
- `route_tables.tf` — route tables and associations
- `nat_instance.tf` — NAT Instance (EC2 + user-data for NAT)
- `bastion.tf` — Bastion Host (EC2 for SSH access)
- `security.tf` — Security Groups and (optionally) Network ACLs
- `variables.tf` — all infrastructure variables
- `outputs.tf` — outputs (e.g., IP addresses, resource IDs)

### Architecture
- VPC: 172.31.0.0/16, region eu-central-1
- 2 public subnets (172.31.1.0/24, 172.31.2.0/24) in different AZs (eu-central-1a, eu-central-1b)
- 2 private subnets (172.31.101.0/24, 172.31.102.0/24) in different AZs
- Internet Gateway for public subnets to access the internet
- NAT Instance (EC2) in one of the public subnets to provide internet access for private subnets (Cheaper way)
- Bastion Host (EC2) for SSH access to private subnets
- Security Groups: SSH access allowed only from IP 37.214.3.227, all other rules follow the principle of least privilege

Each file will be filled with the corresponding Terraform code in the following steps. After each step, a separate commit will be made.
