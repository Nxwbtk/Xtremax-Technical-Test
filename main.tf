provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block = var.vpc_cidr_block
  vpc_cidr_pool = var.vpc_cidr_pool
}