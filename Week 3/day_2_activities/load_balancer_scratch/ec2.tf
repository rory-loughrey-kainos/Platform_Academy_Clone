resource "aws_instance" "server" {
  count                       = var.counts.instances
  ami                         = "ami-0ed752ea0f62749af"
  instance_type               = "t2.micro"
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.ec2-sg.id]
  key_name  = aws_key_pair.ssh_key.key_name
  subnet_id = aws_subnet.private[count.index].id
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

  //depends_on = []

  tags = {
    Name = "ec2-${count.index}${var.root-name}"
  }
}

//pub ec2
resource "aws_instance" "setup" {
  count                       = var.counts.instances
  ami                         = "ami-0ed752ea0f62749af"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.alb-sg.id]
  key_name                    = aws_key_pair.ssh_key.key_name
  subnet_id                   = aws_subnet.public[count.index].id
  root_block_device {
    delete_on_termination = true
    volume_size           = 8
    volume_type           = "gp3"
    encrypted             = true
  }

  //depends_on = []

  tags = {
    Name = "ec2-pub${count.index}${var.root-name}"
  }
}