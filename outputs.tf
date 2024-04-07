# OUTPUT TO RETRIVE THE WEB LOAD BALANCER DNS
output "web_load_balancer_dns" {
  value = module.web.web_load_balancer_dns
} 