
# ID OF THE VPC IN WHERE THE SUBNETS WILL BE
variable "vpc_id"{
    type        = string
}
# The ID of the AMI containing your Django project setup
variable "image_id" {
 
  type        = string
}
# Instance type for your Django application

variable "instance_type" {
  type        = string
}

# Name of the SSH key pair used to access the instances
variable "key_name" {
  type        = string
}
# Minimum number of instances in the Auto Scaling Group
variable "min_size" {
  type        = number
}
# Maximum number of instances in the Auto Scaling Group
variable "max_size" {
  type        = number
}
# Desired number of instances in the Auto Scaling Group
variable "desired_capacity" {
 
  type        = number
}
# variable for subnetes ids
variable "app_subnet_id" {
  description = " "
  type = list
}
# Load balancer subnetes 
variable "lb_subnets"{
    type = list(string)
}


