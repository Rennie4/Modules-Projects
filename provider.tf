provider "aws" {
  region = "eu-west-1"
}
data "aws_caller_identity" "current" {}
output "caller" {
  value = data.aws_caller_identity.current
}



terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

