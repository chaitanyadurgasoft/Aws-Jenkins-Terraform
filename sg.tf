resource "aws_security_group" "Demp-security-Web" {
  vpc_id = aws_vpc.Demo-VPC.id
  name   = "Allow web Application Port"
  tags = {
    Name = "${var.vpc_name}-Security-Group"
  }
  description = "allowing web server ports"
  dynamic "ingress" {
    for_each = local.ingress_rule1
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "Demp-security-App" {
  vpc_id = aws_vpc.Demo-VPC.id
  name   = "Allow  Application Port"
  tags = {
    Name = "${var.vpc_name}-Security-Group"
  }
  description = "allowing App server ports"
  dynamic "ingress" {
    for_each = local.ingress_rule2
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
