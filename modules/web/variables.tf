# VARIABLE TO GET THE VPC ID TO BE USED IN SECURITY GROUP
variable "vpc_id"{
  type = string
}


# list of [list of public subnets , list of private subnets]
variable "lb_subnets"{
    type = list(string)
}
# VARIABLE TO CREATE 1 INSTANCE IN EACH PUBLIC SUBNET
variable "web_subnet_id" {
  type = list
}

# variable used in nginx script to proxy to the private load balancer
# variable "priv_lb_dns" {} 