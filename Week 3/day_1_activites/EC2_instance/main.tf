terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  profile = "KPA-Belfast-23"
}

resource "aws_instance" "app_server" {
  ami                         = "ami-0ed752ea0f62749af"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  //ecurity_groups             = [aws_security_group.seg_group.id]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = aws_key_pair.ssh_key.key_name
  subnet_id              = aws_subnet.public_subnet.id
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
  sudo dnf install mariadb105
  echo "*** Completed Installing mysql"
  EOF

  tags = {
    Name = "lamp-server-rory"
  }
}

