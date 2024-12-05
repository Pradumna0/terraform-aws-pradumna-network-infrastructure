variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones to distribute subnets"
  type        = list(string)
}






#New
# variable "vpc_cidr" {
#   description = "CIDR for the VPC"
# }

# variable "vpc_name" {
#   description = "Nmae for the VPC"
# }


# variable "vpc_id" {
#   description = "VPC ID"
# }

# variable "public_subnets" {
#   description = "List of public subnets"
#   type        = list(object({
#     cidr = string
#     az   = string
#     name = string
#   }))
# }

# variable "private_subnets" {
#   description = "List of private subnets"
#   type        = list(object({
#     cidr = string
#     az   = string
#     name = string
#   }))
# }
