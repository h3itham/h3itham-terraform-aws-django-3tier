
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
  vpc_id        = module.vpc.vpc_id
  web_subnet_id = module.subnet.web_subnets_id
  lb_subnets    = module.subnet.web_subnets_id
  app_lb_dns    = module.app.app_lb_dns

}

module "app" {
  source = "./modules/app"
  app_subnet_1_id = module.subnet.app_subnet_1_id
  app_subnet_2_id = module.subnet.app_subnet_2_id
  vpc_id            = module.vpc.vpc_id
  image_id          = var.image_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  min_size          = var.min_size
  max_size          = var.max_size
  desired_capacity  = var.desired_capacity
  lb_subnets        = module.subnet.web_subnets_id
  dbname            = var.dbname 
  dbusername        = var.dbusername
  dbpassword        = var.dbpassword 
  dbhost            = module.database.dbhost 
}

module "database" {
  source = "./modules/database"
  vpc_id         = module.vpc.vpc_id
  db_subnet_1_id = module.subnet.db_subnet_1_id
  db_subnet_2_id = module.subnet.db_subnet_2_id
  dbname         = var.dbname 
  dbusername     = var.dbusername 
  dbpassword     = var.dbpassword 

  
}