
#VPC mudole O/P
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}


#Nat gateway  mudule Output
output "nat_gateway_id" {
  value = module.nat_gateway.nat_gateway_id
}

output "nat_eip" {
  value = module.nat_gateway.nat_eip
}

#SECURITY grp O/P
output "ec2_security_group_id" {
  value = module.security_group.security_group_id
}

output "alb_security_group_id" {
  value = module.security_group.security_group_id_alb
}

# IGW
output "internet_gateway_id" {
  value = module.internet_gateway.internet_gateway_id
}

# ALB
output "dns_name" {
  value = module.alb.dns_name
}

output "target_group_arn" {
  value = module.alb.target_group_arn
}

output "arn" {
  value = module.alb.arn
}


#launchFront
output "launch_template_id" {
  value = module.launch_template.launch_template_id
}

output "launch_template_name" {
  value = module.launch_template.launch_template_name
}


#cloudfront
output "cloudfront_url" {
  description = "We can access the website using this URL"
  value       = aws_cloudfront_distribution.pradumna_task_01_distribution.domain_name
}


