# OUTPU TO RETRIVE ALL PUBLIC SUBNETS ID
output "web_subnets_id" {
    value = aws_subnet.web_subnets[*].id
}

# OUTPU TO RETRIVE ALL PUBLIC SUBNETS ID
output "app_subnets_id" {
    value = aws_subnet.app_subnets[*].id
}
