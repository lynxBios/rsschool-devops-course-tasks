terraform {
  backend "s3" {
    bucket  = "lynxr-terraform-state"
    key     = "terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
  }
}
