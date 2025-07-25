resource "aws_route_table" "Demo-Public-Route" {
  vpc_id = aws_vpc.Demo-VPC.id
  tags = {
    Name = "${var.vpc_name}-Public-Route"
  }
  route {
    gateway_id = aws_internet_gateway.Demo-IGW.id
    cidr_block = "0.0.0.0/0"
  }
}

resource "aws_route_table" "Demo-Private-Route" {
  vpc_id = aws_vpc.Demo-VPC.id
  tags = {
    Name = "${var.vpc_name}-Private-Route"
  }
}

resource "aws_route_table_association" "Demo-Public-Route-Association" {
  count          = length(var.Public_Subnet_Cidr)
  route_table_id = aws_route_table.Demo-Public-Route.id
  subnet_id      = element(aws_subnet.Demo-Public-Subnets.*.id, count.index)
}
resource "aws_route_table_association" "Demo-Private-Route-Association" {
  count          = length(var.Private_Subnet_Cidr)
  route_table_id = aws_route_table.Demo-Private-Route.id
  subnet_id      = element(aws_subnet.Demo-Private-Subnets.*.id, count.index)
}