# CREATE A VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags       = {
    Name     = "django-VPC"
  }
}
# CREATE AN INTERNET GATEWAY
resource "aws_internet_gateway" "igw" {
  vpc_id  = aws_vpc.vpc.id
  tags    = {
    Name  = "django-IGW"
  }
}
# CREATE ELASTIC IP
resource "aws_eip" "eip" {
  domain   = "vpc"
}
# CREATE NAT IN THE FIRST PUBLIC SUBNET
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = var.nat_subnet_id
  tags       = {
     Name     = "dajngo-NAT"
  }
  depends_on = [aws_internet_gateway.igw]
}