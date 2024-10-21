variable "aws_access_key" {
  type      = string
  sensitive = true
}

variable "aws_secret_key" {
  type      = string
  sensitive = true
}

variable "aws_region" {
  type = string
}

variable "githubActions_role_arn" {
  type = string
}

variable "repository" {
  type = string
}

variable "account_id" {
  type = string
}
