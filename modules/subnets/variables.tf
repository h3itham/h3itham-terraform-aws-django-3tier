# ID of the vpc in where the subnets will be
variable "vpc_id"{

    type        = string
}

variable "web_subnets"{
  description = "web subnets info"
  type        = list(object({
    subnets_cidr      = string
    availability_zone = string
  }))
}
# ID of the IGW to be used in route table for public subnets
variable "igw_id"{
    type = string
}

variable "app_subnets"{
description = "app subnets info"
  type = list(object({
    subnets_cidr = string
    availability_zone = string
  }))
}

variable "db_subnets"{
description = "db subnets info"
  type = list(object({
    subnets_cidr = string
    availability_zone = string
  }))
}

variable "nat_id"{
    description = "ID of the NAT to be used in route table for private subnets"
    type = string
}