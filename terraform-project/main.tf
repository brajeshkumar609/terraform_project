##############################################
# VPC
##############################################
module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
  environment          = var.environment
  common_tags          = var.common_tags
}

##############################################
# Security Group
##############################################
module "security_group" {
  source      = "./modules/security-group"
  vpc_id      = module.vpc.vpc_id
  environment = var.environment
  common_tags = var.common_tags
}

##############################################
# EC2 (in first private subnet)
##############################################
module "ec2" {
  source            = "./modules/ec2"
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  key_name          = var.key_name

  subnet_id         = module.vpc.private_subnet_ids[0]
  security_group_id = module.security_group.security_group_id

  environment = var.environment
  common_tags = var.common_tags
}
