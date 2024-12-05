resource "aws_eip" "nat" {
  count  = length(var.public_subnet_ids) #2
  domain = "vpc"
}

resource "aws_nat_gateway" "main" {
  count         = length(var.public_subnet_ids)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = element(var.public_subnet_ids, count.index)

  tags = {
    Name = "NATGateway-${count.index + 1}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id
  count  = length(var.public_subnet_ids)


  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = {
    Name = "PrivateRouteTable-${count.index + 1}"
  }
}

resource "aws_route_table_association" "private" {
  count          = 2
  subnet_id      = element(var.private_subnet_ids, count.index)
  route_table_id = aws_route_table.private[count.index].id
}
