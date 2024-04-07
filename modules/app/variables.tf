# ID OF THE VPC IN WHERE THE SUBNETS WILL BE
variable "vpc_id"{
    type        = string
}
# The ID of the AMI containing your Django project setup
variable "image_id" {
 
  type        = string
}
# INSTANCE TYPE FOR YOUR DJANGO APPLICATION

variable "instance_type" {
  type        = string
}

# NAME OF THE SSH KEY PAIR USED TO ACCESS THE INSTANCES
variable "key_name" {
  type        = string
}
# MINIMUM NUMBER OF INSTANCES IN THE AUTO SCALING GROUP
variable "min_size" {
  type        = number
}
# MAXIMUM NUMBER OF INSTANCES IN THE AUTO SCALING GROUP
variable "max_size" {
  type        = number
}
# DESIRED NUMBER OF INSTANCES IN THE AUTO SCALING GROUP
variable "desired_capacity" {
 
  type        = number
}
# VARIABLE FOR APP SUBNET 1 
variable "app_subnet_1_id" {
  type = string 
  
}

# VARIABLE FOR APP SUBNET 2 
variable "app_subnet_2_id" {
  type = string 
  
}
# LOAD BALANCER SUBNETES 
variable "lb_subnets"{
    type = list(string)
}

# DATABASE NAME 
variable "dbname" {
  type = string
  
}
# DATABASE USERNAME
variable "dbusername" {
  type = string
}
# DATABASE PASSWORD
variable "dbpassword" {
  type = string 
} 

# DATABASE HOST

variable "dbhost" {
  type = string   
}

