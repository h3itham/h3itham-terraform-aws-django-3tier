provider "aws" {
  profile           = var.profile
  region            = var.region
}

module "vpc" {
  source            = "./modules/vpc"
  vpc_cidr          = var.vpc_cidr
  nat_subnet_id     = module.subnet.web_subnets_id[0]
}

module "subnet" {
  source            = "./modules/subnets"
  vpc_id            = module.vpc.vpc_id
  web_subnets       = var.web_subnets
  app_subnets       = var.app_subnets
  db_subnets        = var.db_subnets 
  igw_id            = module.vpc.igw_id
  nat_id            = module.vpc.nat_id
}

module "web"  { 
  source = "./modules/web"
  vpc_id = module.vpc.vpc_id
  web_subnet_id = module.subnet.web_subnets_id
  lb_subnets     = module.subnet.web_subnets_id
  # not configured yet 
  # priv_lb_dns = 

}