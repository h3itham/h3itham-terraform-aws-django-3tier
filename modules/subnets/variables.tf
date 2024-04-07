# ID of the vpc in where the subnets will be
variable "vpc_id"{

    type        = string
}
# WEB sUBNETES INFO
variable "web_subnets"{
  type        = list(object({
    subnets_cidr      = string
    availability_zone = string
  }))
}
# APP SUBNETS INFO
variable "app_subnets"{
  type = list(object({
    subnets_cidr = string
    availability_zone = string
  }))
}
# DB SUBNETS INFO
variable "db_subnets"{
  type = list(object({
    subnets_cidr = string
    availability_zone = string
  }))
}
# ID OF THE IGW TO BE USED IN ROUTE TABLE FOR PUBLIC SUBNETS
variable "igw_id"{
    type = string
}
# ID OF THE NAT TO BE USED IN ROUTE TABLE FOR PRIVATE SUBNETS 
variable "nat_id"{
    description = ""
    type = string
}