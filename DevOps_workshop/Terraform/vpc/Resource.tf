# # Resource
# resource "aws_instance" "my-instance" {
#   ami           = "ami-0fc5d935ebf8bc3bc"
#   instance_type = "t2.micro"
#   key_name      = "ksnv_key"

#   security_groups        = ["my_sg"]
#   vpc_security_group_ids = [aws_security_group.my_sg.id]
#   subnet_id              = aws_subnet.my_pub_subnet_01.id

#   for_each = toset(["Jenkins_master", "Ansible", "Slave"])
#   tags = {
#     Name = "${each.key}"
#   }
# }