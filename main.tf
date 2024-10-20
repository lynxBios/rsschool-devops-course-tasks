provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

resource "aws_s3_bucket" "rs-school-bucket-1" {
  bucket = "rs-school-bucket-1"
}

resource "aws_s3_bucket_ownership_controls" "ownership_controls" {
  bucket = aws_s3_bucket.rs-school-bucket-1.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
