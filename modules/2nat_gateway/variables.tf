variable "vpc_id" {
  description = "The VPC ID where the NAT Gateway will be created"
  type        = string
}

variable "private_subnet_ids" {
  description = "The private subnet IDs that will use the NAT Gateway for internet access"
  type        = list(string)
}


variable "public_subnet_ids" {
  description = "The public subnet ID where the NAT Gateway will reside"
  type        = list(string)
}


