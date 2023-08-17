terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.2.0"
}
resource "aws_instance" "rory_ec2" {
  ami             = data.aws_ami.ubuntu.id //ubuntu 20.04 lts
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.public_subnet.id
  key_name        = aws_key_pair.ssh_key.key_name
  security_groups = [aws_security_group.sg.id]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.access_key_priv.private_key_pem
    host        = aws_instance.web.public_ip
  }

  associate_public_ip_address = true

  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  echo "*** Completed Installing apache2"
  EOF

  tags = {
    Name = "rl_ec2"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

# data "aws_key_pair" "vpc_key_pair" {
#   key_name           = "ssh_key"
#   include_public_key = true

#   filter {
#     name   = "vpc_ EC2_keypair_rl"
#     values = ["web"]
#   }
# }


