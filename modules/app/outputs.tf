# RETRIVE DNS OF APPLICATION LOADBALANCER
 output "app_lb_dns" {
    value = aws_lb.app-LB.dns_name
 }