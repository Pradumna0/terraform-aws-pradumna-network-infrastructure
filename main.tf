provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/1vpc"

  cidr_block           = var.cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "nat_gateway" {
  source             = "./modules/2nat_gateway"
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_id             = module.vpc.vpc_id #
}

module "security_group" {
  source = "./modules/3security_group"
  vpc_id = module.vpc.vpc_id
}


module "internet_gateway" {
  source            = "./modules/5internet_gateway"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}


module "alb" {
  source                = "./modules/6alb"
  public_subnet_ids     = module.vpc.public_subnet_ids
  vpc_id                = module.vpc.vpc_id                           #
  security_group_id_alb = module.security_group.security_group_id_alb #
}


module "launch_template" {
  source               = "./modules/7launch_template"
  launch_template_name = var.launch_template_name
  instance_type        = var.instance_type
  ami_id               = var.ami_id
  security_group_ids   = [module.security_group.security_group_id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd

              echo "<html>
              <head>
                <title>Welcome</title>
              </head>
              <body>
                <h1>Welcome to Pradumna's Assignment</h1>
                <p>This is a sample web application.</p>
              </body>
              </html>" > /var/www/html/index.html
              EOF
  )
}

# Auto Scaling Group
resource "aws_autoscaling_group" "pradumna_task_01_asg" {
  desired_capacity    = 2 #number of EC2 instances maintain in the group
  max_size            = 5
  min_size            = 1
  vpc_zone_identifier = module.vpc.private_subnet_ids #instances will launch in this subnets

  launch_template {
    id      = module.launch_template.launch_template_id #Associate the ASG with launch template
    version = "$Latest"
  }

  target_group_arns = [module.alb.target_group_arn] #link the ASG to an ALB target group for traffic routing

  tag {
    key                 = "Name"
    value               = "pradumna-task-01-instance"
    propagate_at_launch = true
  }
}

# CloudFront Distribution
resource "aws_cloudfront_distribution" "pradumna_task_01_distribution" {
  #cloudfront will distribute content of ALB
  origin {
    domain_name = module.alb.dns_name
    origin_id   = "pradumna-task-01-alb-origin"

    #How cloudfront communicate with origin
    custom_origin_config { #
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only" #use only http to communicate with the origin
      origin_ssl_protocols   = ["TLSv1.2"] #for HTTPS communication
    }
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id       = "pradumna-task-01-alb-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values { #what data cloudfront forwarded to the origin
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true # *.cloudfront.net     (for HTTPS request)
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

output "cloudfront_url" {
  description = "We can access the website using this URL"
  value       = aws_cloudfront_distribution.pradumna_task_01_distribution.domain_name
}

