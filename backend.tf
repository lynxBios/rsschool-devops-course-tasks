terraform {
    backend "s3" {
        bucket         = "rs-school-bucket-1 "
        key            = "terraform.tfstate"
        region         = "us-west-2"
        encrypt        = true                   
    }
}
