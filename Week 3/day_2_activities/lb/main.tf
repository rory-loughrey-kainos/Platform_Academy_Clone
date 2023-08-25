data "aws_availability_zones" "available" {
  state = "available"

}

resource "aws_instance" "server" {
  count                       = var.counts.ec2
  ami                         = "ami-0ed752ea0f62749af"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.alb_sg.id]
  key_name                    = aws_key_pair.ssh_key.key_name
  subnet_id                   = aws_subnet.public_subnet[count.index].id
  root_block_device {
    delete_on_termination = true
    volume_size           = 8
    volume_type           = "gp3"
    encrypted             = true
  }

  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo dnf update -y
  sudo dnf install -y httpd.x86_64
  sudo systemctl start httpd.service
  sudo systemctl status httpd.service
  sudo systemctl enable httpd.service
  echo "*** Completed Installing apache2"
  EOF

  depends_on = [aws_internet_gateway.gateway]

  tags = {
    Name = "vm${count.index}-rory"
  }
}
/*
resource "aws_instance" "ec2jumphost" {
  count = var.counts.public
  instance_type   = "t2.micro"
  ami             = "ami-0ed752ea0f62749af" # https://cloud-images.ubuntu.com/locator/ec2/ (Ubuntu)
  subnet_id       = aws_subnet.public_subnet[count.index].id
  security_groups = [aws_security_group.nat_sg.id]
  key_name        = aws_key_pair.ssh_key.key_name
  root_block_device {
    delete_on_termination = true
    volume_size           = 8
    volume_type           = "gp3"
    encrypted             = true
  }
  tags = {
    "Name" = "bastion-rory"
  }
}

resource "aws_eip" "jumphost" {
  instance = aws_instance.ec2jumphost.id
  vpc      = true
}

output "jumphost_ip" {
  value = aws_eip.jumphost.public_ip
}
*/