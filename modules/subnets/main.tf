# CREATE WEB SUBNETS
resource "aws_subnet" "web_subnets" {
  count             = length(var.web_subnets)
  vpc_id            = var.vpc_id
  cidr_block        = var.web_subnets[count.index].subnets_cidr
  availability_zone = var.web_subnets[count.index].availability_zone
  tags = {
    Name = "web_subnet_${count.index}"
  }
}
# CREATE PUBLIC ROUTE TABLE 
resource "aws_route_table" "public-rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
}

# ASSIGN THE PUBLIC ROUTE TABLE TO ALL WEB SUBNETS
resource "aws_route_table_association" "public-rta" {
  count          = length(aws_subnet.web_subnets)
  subnet_id      = aws_subnet.web_subnets[count.index].id
  route_table_id = aws_route_table.public-rt.id
}

# CREATE APP SUBNETS
resource "aws_subnet" "app_subnets" {
  count             = length(var.app_subnets)
  vpc_id            = var.vpc_id
  cidr_block        = var.app_subnets[count.index].subnets_cidr
  availability_zone = var.app_subnets[count.index].availability_zone
  tags = {
    Name = "app_subnet_${count.index}"
  }
}
# CREATE PRIVATE ROUTE TABLE 
resource "aws_route_table" "private-rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_id
  }
}

# ASSIGN THE PRIVATE ROUTE TABLE TO ALL APP SUBNETS
resource "aws_route_table_association" "private-rta" {
  count          = length(aws_subnet.app_subnets)
  subnet_id      = aws_subnet.app_subnets[count.index].id   
  route_table_id = aws_route_table.private-rt.id
}
# CREATE DB SUBNETS
resource "aws_subnet" "db_subnets" {
  count             = length(var.db_subnets)
  vpc_id            = var.vpc_id
  cidr_block        = var.db_subnets[count.index].subnets_cidr
  availability_zone = var.db_subnets[count.index].availability_zone
  tags = {
    Name = "db_subnet_${count.index}"
  }
}

# ASSIGN THE PRIVATE ROUTE TABLE TO ALL DB SUBNETS
resource "aws_route_table_association" "db-rta" {
  count          = length(aws_subnet.db_subnets)
  subnet_id      = aws_subnet.db_subnets[count.index].id   
  route_table_id = aws_route_table.private-rt.id
}
