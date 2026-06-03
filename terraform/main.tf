module "vpc" {
  source = "./modules/vpc"
  # target_env = terraform.workspace
  aws_region = var.aws_region
  vpc_cidr   = var.vpc_cidr
  pub_subnet = var.public_subnet
  pri_subnet = var.private_subnet
}

#  compute module
module "compute" {
  source = "./modules/compute"
  # target_env    = terraform.workspace
  vpc_id        = module.vpc.vpc_id
  pub_subnet_id = module.vpc.public_subnet_id
  #pri_subnet_id = module.vpc.private_subnet_id
  instance_type = var.instance_type
}
