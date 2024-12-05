variable "launch_template_name" {
  description = "The name of the launch template"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type     (e.g., t2.micro)"
  type        = string
}

variable "ami_id" {
  description = "Amazon Machine Image (AMI) ID to launch instances"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the instances"
  type        = list(string)
}

variable "user_data" {
  description = "User data script to configure the instance"
  type        = string
  #   default     = <<-EOF
  #               #!/bin/bash
  #               sudo yum update -y
  #               sudo yum install -y httpd
  #               sudo systemctl start httpd
  #               sudo systemctl enable httpd

  #               echo "<html>
  #               <head>
  #                 <title>Welcome</title>
  #               </head>
  #               <body>
  #                 <h1>Welcome to Pradumna's Assignment</h1>
  #                 <p>This is a sample web application.</p>
  #               </body>
  #               </html>" > /var/www/html/index.html
  #               EOF
}