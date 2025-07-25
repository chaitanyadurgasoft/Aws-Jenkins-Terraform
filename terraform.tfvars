region              = "us-east-1"
vpc_cidr            = "10.200.0.0/16"
vpc_name            = "DemoApp"
Public_Subnet_Cidr  = ["10.200.1.0/24", "10.200.2.0/24", "10.200.3.0/24"]
az                  = ["us-east-1a", "us-east-1b", "us-east-1c"]
Private_Subnet_Cidr = ["10.200.10.0/24", "10.200.20.0/24", "10.200.30.0/24"]
key = {
  "us-east-1" = "Default_Key"
  "us-east-2" = "Default_Key"
}
instance_type = "t2.micro"
env           = "Dev"