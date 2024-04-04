# APPLICATION SECURITY GROUP 
resource "aws_security_group" "django-SG" {
    vpc_id          = var.vpc_id
    ingress {
        from_port   = 22 
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }
    ingress {
        from_port   = 80 
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }
    ingress {
        from_port   = 8000
        to_port     = 8000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" 
        cidr_blocks = ["0.0.0.0/0"]
        }
    }

# PROJECT LAUCH CONFIGURATION 
resource "aws_launch_configuration" "django-LC" {
  name              = "django-LC"
  image_id          = var.image_id
  instance_type     = var.instance_type
  key_name          = var.key_name 
  security_groups   = [aws_security_group.django-SG.id]
 
  
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y python3-pip > /dev/null 2>&1
              git clone https://github.com/h3itham/SimpleDjangoApp.git /home/ubuntu/project
              cd /home/ubuntu/project/
              sudo pip3 install -r requirements.txt
              sudo python3 manage.py migrate
              sudo nohup python3 manage.py runserver 0.0.0.0:80 &
              EOF
   
}

# AUTO SCALING GROUP FOR DJANGO APPLICATION 
resource "aws_autoscaling_group" "django-ASG" {
  count                    = length(var.app_subnet_id) 
  name                     = "django-ASG"
  launch_configuration     = aws_launch_configuration.django-LC.name
  min_size                 = var.min_size
  max_size                 = var.max_size
  desired_capacity         = var.desired_capacity 
  vpc_zone_identifier      = toset([var.app_subnet_id[count.index]])
  target_group_arns        = [aws_lb_target_group.app-TG.arn]
  health_check_type        = "ELB"
  health_check_grace_period = 300 
   tag {
    key                 = "foo"
    value               = "bar"
    propagate_at_launch = true
  }
}

# APP LOAD BALANCER 
resource "aws_lb" "app-LB" {

    name               = "app-LB"
    load_balancer_type = "application"
    subnets            = var.lb_subnets
    security_groups    = [aws_security_group.django-SG.id]
}
# TARGET GROUP 
resource "aws_lb_target_group" "app-TG" {
	name     = "app-TG"
	port 	 = 80 
	protocol = "HTTP"
	vpc_id   = var.vpc_id
}

# WEB LISTENER 
resource "aws_lb_listener" "app-listner" {
    load_balancer_arn = aws_lb.app-LB.arn
    port              = "80"
    protocol          = "HTTP"
    default_action {
        type              = "forward"
        target_group_arn = aws_lb_target_group.app-TG.id
  }
}
