resource "aws_vpc" "Demo-VPC" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "Demo-IGW" {
  vpc_id = aws_vpc.Demo-VPC.id
  tags = {
    Name = "${var.vpc_name}-IGW"
  }
}