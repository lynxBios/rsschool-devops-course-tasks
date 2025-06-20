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
