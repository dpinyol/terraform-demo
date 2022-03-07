terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.4.0"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
}

# DATASOURCES
#data "aws_ssm_parameter" "ami" {
#  name = "/aws/service/ami/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
#}
