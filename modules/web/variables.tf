# VARIABLE TO GET THE VPC ID TO BE USED IN SECURITY GROUP
variable "vpc_id"{
  type = string
}
# LIST OF  PUBLIC SUBNETS , LIST OF PRIVATE SUBNETS
variable "lb_subnets"{
    type = list(string)
}
# VARIABLE TO CREATE 1 INSTANCE IN EACH PUBLIC SUBNET
variable "web_subnet_id" {
  type = list
}
# vARIABLE USED IN NGINX SCRIPT TO PROXY TO THE PRIVATE LOAD BALANCER
variable "app_lb_dns" {} 