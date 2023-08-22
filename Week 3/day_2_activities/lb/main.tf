data "aws_availability_zones" "available" {
  state = "available"

}

resource "aws_instance" "server_a" {
  count                       = 1
  ami                         = "ami-0ed752ea0f62749af"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = aws_key_pair.ssh_key.key_name
  subnet_id              = aws_subnet.public_subnet[count.index].id
  root_block_device {
    delete_on_termination = true
    volume_size           = 8
    volume_type           = "gp3"
    encrypted             = true
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.access_key_priv.private_key_pem
    host        = aws_instance.app_server.public_ip
  }

  user_data = <<-EOF
  #!/bin/bash
  sudo yum update
  echo "*** Installing mysql"
  sudo dnf install mariadb105 -y
  echo "*** Completed Installing mysql"
  EOF

  depends_on = [ aws_internet_gateway.gateway ]

  tags = {
    Name = "vma-rory"
  }
}

resource "aws_instance" "server_b" {
  count                       = 1
  ami                         = "ami-0ed752ea0f62749af"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = aws_key_pair.ssh_key.key_name
  subnet_id              = aws_subnet.public_subnet[count.index].id
  root_block_device {
    delete_on_termination = true
    volume_size           = 8
    volume_type           = "gp3"
    encrypted             = true
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.access_key_priv.private_key_pem
    host        = aws_instance.app_server.public_ip
  }

  user_data = <<-EOF
  #!/bin/bash
  sudo yum update
  echo "*** Installing mysql"
  sudo dnf install mariadb105 -y
  echo "*** Completed Installing mysql"
  EOF

  depends_on = [ aws_internet_gateway.gateway ]

  tags = {
    Name = "vmb-rory"
  }
}