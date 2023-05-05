resource "aws_instance" "bradt_private_instance" {
  ami = var.image
  instance_type = var.instance_type
  subnet_id = aws_subnet.bradt_private_subnet.id
  key_name = aws_key_pair.instance_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.bradt_bh_sg.id]

  tags = {
   Name = "Private Instance"
  }
}


resource "aws_instance" "bradt_bastion_host" {
   depends_on = [
     aws_instance.bradt_private_instance
  ]
  
  ami = var.image
  instance_type = var.instance_type
  subnet_id = aws_subnet.bradt_public_subnet.id
  key_name = aws_key_pair.bastion_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.bradt_bh_sg.id]
  tags = {
   Name = "Bastion Host"
  }
}