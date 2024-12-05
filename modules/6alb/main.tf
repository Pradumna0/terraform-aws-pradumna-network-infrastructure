#create Public facing ALB deploy in public subnet 
resource "aws_lb" "main" {
  name               = "pradumna-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id_alb]
  subnets            = var.public_subnet_ids
}

#Define a group of EC2 instances to recieve  traffic routed by the ALB on port 80 using HTTP.
resource "aws_lb_target_group" "main" { #This target group recieve traffic routed by the ALB
  name        = "pradumna-tg"
  port        = 80 # target group recieve traffic
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance" # target group contains ec2 instances as target
}


#configure the ALB to listen HTTP traffic on port 80 and forward request ton the target group
resource "aws_lb_listener" "http" {   #Handle HTTP traffic
  load_balancer_arn = aws_lb.main.arn #attached listner to ALb 
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"                    #forwarded incoming request to target group
    target_group_arn = aws_lb_target_group.main.arn #forward the request
  }
}



