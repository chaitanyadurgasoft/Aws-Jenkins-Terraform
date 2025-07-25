output "vpc_id" {
  value = aws_vpc.Demo-VPC.id
}

output "All_Subnet_Ids" {
  value = aws_subnet.Demo-Public-Subnets.*.id
}

output "Subnet_1_id" {
  value = aws_subnet.Demo-Public-Subnets.0.id
}

output "Subnet_2_id" {
  value = aws_subnet.Demo-Public-Subnets.1.id
}

output "Subnet_3_id" {
  value = aws_subnet.Demo-Public-Subnets.2.id
}

output "instance_public_IP" {
  value = aws_instance.Demo_Web_Public_Instance.*.public_ip
}
