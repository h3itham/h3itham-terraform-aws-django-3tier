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


# Auto scaling variables 
variable "image_id" {
  description = "The ID of the AMI containing your Django project setup"
  type        = string
}

variable "instance_type" {
  description = "Instance type for your Django application"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair used to access the instances"
  type        = string
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
}

variable "dbname" {
  type = string
}
variable "dbusername" {
  type = string 
}

variable "dbpassword" {
  type = string 
}