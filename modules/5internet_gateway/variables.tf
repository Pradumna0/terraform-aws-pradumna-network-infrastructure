variable "vpc_id" {
  description = "The VPC ID where the Internet Gateway will be created"
  type        = string
}

variable "public_subnet_ids" {
  description = "The public subnet IDs that will use the  Internet Gateway for internet access"
  type        = list(string)
}