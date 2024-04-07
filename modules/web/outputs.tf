# OUTPU TO RETRIVE ALL PUBLIC INSTANCES IP
output "web_ec2_id" {
  value = aws_instance.web-nginx[*].id
}
# OUTPUT TO RETRIVE SECURITY GROUP ID TO BE USED IN LOAD BALANCER 
output "security_group_id" {
    value = aws_security_group.web-SG.id
}
# OUTPUT TO RETRIVE THE WEB LOAD BALANCER DNS
output "web_load_balancer_dns" {
  value = aws_lb.web-LB.dns_name
} 