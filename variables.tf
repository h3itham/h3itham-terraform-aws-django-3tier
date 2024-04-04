# providers variables 
variable "profile" {}
variable "region" {}

# vpc module  variables
variable "vpc_cidr"{}

# subnet module variables
variable "web_subnets"{
    type              = list(object({
    subnets_cidr      = string
    availability_zone = string
  }))
}

variable "app_subnets"{
    type              = list(object({
    subnets_cidr      = string
    availability_zone = string
  }))
}

variable "db_subnets"{
    type              = list(object({
    subnets_cidr      = string
    availability_zone = string
  }))
}
