terraform {
  backend "s3" {
    bucket  = "tf-state-devops-2025q2"
    key     = "terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}
