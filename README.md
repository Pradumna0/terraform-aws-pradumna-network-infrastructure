# terraform-aws-network-infrastructure


## Overview
This terraform module orchestrates the deployment of a complete AWS infrastructure by invoking several sub-modules and defining their dependencies and variables. It sets up a scalable and secure architecture with a VPC, subnets, NAT gateways, an ALB, EC2 instances, an Auto Scaling Group (ASG), and a CloudFront distribution.
This module provides a complete and flexible architecture for deploying a web application on AWS, adhering to best practices for security, scalability, and performance.

1. Main Infrastructure

The main.tf file in the root module defines how the various sub-modules interact. It:

Deploys a VPC for resource isolation.

Configures public and private subnets within the VPC.

Sets up NAT gateways for private subnet internet access.

Creates an Application Load Balancer (ALB) to distribute traffic across EC2 instances.

Configures an Auto Scaling Group (ASG) to ensure high availability.

Deploys a CloudFront Distribution for caching and global content delivery.



---

2. Inputs

The variables.tf file defines parameters that make the module flexible and reusable:

Networking: CIDR blocks for VPC, public, and private subnets.

Scaling: Minimum, maximum, and desired ASG size.

Instance Configuration: AMI ID, instance type, and user data.

Naming: Resource name prefixes for easy identification.



---

3. Outputs

The outputs.tf file provides key information about the deployed resources:

IDs: VPC, subnet, ALB, ASG, NAT gateway, and CloudFront distribution IDs.

Endpoints: ALB DNS name and CloudFront distribution URL.



---

4. Variables File

The terraform.tfvars file allows customization of inputs:

Defines values for variables like cidr_block, public_subnet_cidrs, private_subnet_cidrs, ami_id, asg_size, etc.

Simplifies deployment by centralizing environment-specific configurations.



---

Modules Used in Root Module

1. VPC Module:

Provisions the VPC and outputs its ID.



2. Subnet Module:

Creates public and private subnets using the VPC ID.



3. NAT Gateway Module:

Configures NAT gateways in public subnets to enable private subnet internet access.



4. ALB Module:

Deploys an Application Load Balancer to manage incoming traffic.



5. ASG Module:

Provisions EC2 instances and manages scaling with an Auto Scaling Group.



6. CloudFront Module:

Sets up a CloudFront distribution to serve the web application globally with caching.






## How It Works

1. The VPC module creates the foundational networking layer.


2. The Subnet module adds public and private subnets within the VPC.


3. The NAT Gateway module ensures private subnets can access the internet.


4. The ALB module serves as the frontend for traffic, distributing requests to EC2 instances.


5. The ASG module launches and scales EC2 instances as needed.


6. The CloudFront module adds a global CDN layer to optimize content delivery.




---

## Benefits of This Design

Scalability: Auto Scaling ensures dynamic response to traffic changes.

Security: Private subnets and security groups restrict unauthorized access.

Cost-Effectiveness: NAT gateways and auto-scaling optimize resources.

Performance: CloudFront ensures low-latency content delivery worldwide.

Modularity: Each module is reusable, making maintenance and updates easier.




## USAGE

```
provider "aws" {
  region = "ap-south-1"   #replace with your region
}
module "pradumna-network-infrastructure" {
  source  = "Pradumna0/pradumna-network-infrastructure/aws"
  version = "1.1.0"
  cidr_block           = "Use your cidr"
  public_subnet_cidrs  = ["Use your public subnets"]
  private_subnet_cidrs = ["Use your private subnets according to your requirements"]
  availability_zones   = ["ap-south-1a", "ap-south-1b"]
  instance_type        = "t2.micro"
  ami_id               = "ami-123" #You can Replace with your actual ami_id
  launch_template_name = "xyz-template"
}
```