# CREATE A SECURITY GROUP
resource "aws_security_group" "web-SG" {
  vpc_id = var.vpc_id
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-SG"
  }
}

# LAUNCHE WEB-Nginx 
resource "aws_instance" "web-nginx" {
  count                       = length(var.web_subnet_id) 
  ami                         = "ami-080e1f13689e07408"
  instance_type               = "t2.micro"
  subnet_id                   = var.web_subnet_id[count.index]    
  security_groups             = [aws_security_group.web-SG.id]
  associate_public_ip_address = true
  tags = {
      Name = "web-nginx_${count.index}"
    } 

    user_data = <<EOF
#!/bin/bash
sudo apt-get update
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo cat > /etc/nginx/sites-enabled/default << EOL
server {
    listen 80 default_server;
    location / {
      proxy_pass http://${var.app_lb_dns};
    }
}
EOL
sudo systemctl restart nginx
EOF

}

# WEB LOAD BALANCER 
resource "aws_lb" "web-LB" {

    name              = "web-LB"
    load_balancer_type = "application"
    subnets           = var.lb_subnets
    security_groups   = [aws_security_group.web-SG.id]
}
# TARGET GROUP 
resource "aws_lb_target_group" "web-TG" {
	name     = "web-TG"
	port 	 = 80 
	protocol = "HTTP"
	vpc_id   = var.vpc_id
	
}

# ATTACHE TARGET GROUP TO WEB-NGINX SUBNETS
resource "aws_lb_target_group_attachment" "web-target-group-attachment" {
    count            = length(aws_instance.web-nginx)
    target_group_arn = aws_lb_target_group.web-TG.arn
    target_id        = aws_instance.web-nginx[count.index].id
    port             = 80

}
# WEB LISTENER 
resource "aws_lb_listener" "web-listner" {
    load_balancer_arn = aws_lb.web-LB.arn
    port              = "80"
    protocol          = "HTTP"
    default_action {
        type  = "forward"
        target_group_arn = aws_lb_target_group.web-TG.id
  }
}