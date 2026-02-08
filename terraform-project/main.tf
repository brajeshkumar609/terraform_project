############################################
# VPC MODULE
############################################

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
  environment          = var.environment
  common_tags          = var.common_tags
}

############################################
# SECURITY GROUP MODULE
############################################

module "security_group" {
  source = "./modules/security-group"

  vpc_id      = module.vpc.vpc_id
  environment = var.environment
  common_tags = var.common_tags
}

############################################
# EC2 MODULE (Private Instance Example)
############################################

module "ec2" {
  source = "./modules/ec2"

  ami_id             = var.ami_id
  instance_type      = var.instance_type
  subnet_id          = module.vpc.private_subnet_ids[0]
  security_group_ids = [module.security_group.sg_id]
  key_name           = var.key_name

  environment = var.environment
  common_tags = var.common_tags
}
