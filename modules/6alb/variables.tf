variable "vpc_id" {
  description = "The VPC ID where the ALB will be created"
  type        = string
}

variable "public_subnet_ids" {
  description = "The public subnet IDs that will use the  Internet Gateway for internet access"
  type        = list(string)
}

variable "security_group_id_alb" {
  description = "security group for alb"
  type        = string

}
