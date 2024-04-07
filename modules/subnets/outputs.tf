# OUTPU TO RETRIVE ALL WEB SUBNETS ID
output "web_subnets_id" {
    value = aws_subnet.web_subnets[*].id
}
# OUTPUT OF APP SUBNET 1 ID 
output "app_subnet_1_id" {
    value = aws_subnet.app_subnets[0].id
}
# OUTPUT OF APP SUBNET 2 ID 
output "app_subnet_2_id" {
    value = aws_subnet.app_subnets[1].id
}

# OUTPUT OF DB SUBNET 1 ID
output "db_subnet_1_id" {
    value = aws_subnet.db_subnets[0].id
}
# OUTPUT OF DB SUBNET 2 ID
output "db_subnet_2_id" {
    value = aws_subnet.db_subnets[1].id
}
