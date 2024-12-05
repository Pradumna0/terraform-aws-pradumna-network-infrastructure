resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = "MainVPC"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  cidr_block              = var.public_subnet_cidrs[count.index]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  availability_zone       = element(var.availability_zones, count.index)

  tags = {
    Name = "PublicSubnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  cidr_block              = var.private_subnet_cidrs[count.index]
  vpc_id                  = aws_vpc.main.id
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "PrivateSubnet-${count.index + 1}"
  }
}












