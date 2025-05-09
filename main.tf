provider "aws" {
  region = var.aws_region
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block = var.vpc_cidr_block
  vpc_cidr_pool = var.vpc_cidr_pool
}

module "ec2" {
  source = "./modules/ec2"
}