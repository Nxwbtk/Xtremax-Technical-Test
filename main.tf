provider "aws" {
  region                      = var.aws_region
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_pool      = var.vpc_cidr_pool
  public_cidr_block  = var.public_cidr_block
  private_cidr_block = var.private_cidr_block
}

module "iam_instance_profile" {
  source                = "./modules/iam"
  instance_profile_name = var.instance_profile_name
}
module "alb" {
  source     = "./modules/alb"
  subnet_ids = module.vpc.public_subnet_ids
  vpc_id     = module.vpc.vpc_id
  ec2_sg_id  = module.ec2.ec2_sg_id
}

module "ec2" {
  source                = "./modules/ec2"
  image_id              = var.image_id
  instance_type         = var.instance_type
  iam_instantce_profile = var.instance_profile_name
  subnet_ids            = module.vpc.public_subnet_ids
  vpc_id                = module.vpc.vpc_id
  target_group_arn      = module.alb.target_group_arn
}



module "rds" {
  source                = "./modules/rds"
  vpc_id                = module.vpc.vpc_id
  allowed_cidrs         = module.vpc.private_subnet_ids
  subnet_ids            = module.vpc.private_subnet_ids
  db_identifier         = var.db_identifier
  db_instance_class     = var.db_instance_class
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  db_port               = var.db_port
  ec2_security_group_id = module.ec2.ec2_sg_id

}
