resource "aws_subnet" "Demo-Public-Subnets" {
  count                   = length(var.Public_Subnet_Cidr)
  vpc_id                  = aws_vpc.Demo-VPC.id
  cidr_block              = element(var.Public_Subnet_Cidr, count.index)
  availability_zone       = element(var.az, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-Public-Subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "Demo-Private-Subnets" {
  count             = length(var.Private_Subnet_Cidr)
  vpc_id            = aws_vpc.Demo-VPC.id
  cidr_block        = element(var.Private_Subnet_Cidr, count.index)
  availability_zone = element(var.az, count.index)
  tags = {
    Name = "${var.vpc_name}-Private-Subnet-${count.index + 1}"
  }
}