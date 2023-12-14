# # VPC
# resource "aws_vpc" "my_vpc" {
#   cidr_block = "10.1.0.0/16"

#   tags = {
#     Name = "my_vpc"
#   }
# }


# # Subnet
# resource "aws_subnet" "my_pub_subnet_01" {
#   vpc_id                  = aws_vpc.my_vpc.id
#   cidr_block              = "10.1.1.0/24"
#   availability_zone       = "us-east-1a"
#   map_public_ip_on_launch = "true"

#   tags = {
#     Name = "my_pub_subnet_01"
#   }
# }

# resource "aws_subnet" "my_pub_subnet_02" {
#   vpc_id                  = aws_vpc.my_vpc.id
#   cidr_block              = "10.1.2.0/24"
#   availability_zone       = "us-east-1b"
#   map_public_ip_on_launch = "true"

#   tags = {
#     Name = "my_pub_subnet_02"
#   }
# }

# # Internet_Gateway
# resource "aws_internet_gateway" "my_igw" {
#   vpc_id = aws_vpc.my_vpc.id

#   tags = {
#     Name = "my_igw"
#   }
# }


# # Route_Table
# resource "aws_route_table" "my_rt" {
#   vpc_id = aws_vpc.my_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.my_igw.id
#   }
# }


# # Route_Table_assocation
# resource "aws_route_table_association" "my_rta_pub_subnet_01" {
#   subnet_id      = aws_subnet.my_pub_subnet_01.id
#   route_table_id = aws_route_table.my_rt.id
# }
# resource "aws_route_table_association" "my_rta_pub_subnet_02" {
#   subnet_id      = aws_subnet.my_pub_subnet_02.id
#   route_table_id = aws_route_table.my_rt.id
# }