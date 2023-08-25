resource "aws_instance" "server" {
  count         = var.counts.instances
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  subnet_id              = aws_subnet.private[floor(count.index % var.counts.private_subnets)].id
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]

  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  echo "*** Completed Installing apache2"
  echo "<h1>loading from $(hostname -f)..</h1>" > /var/www/html/index.html
  EOF

  lifecycle {
    create_before_destroy = true
  }


  tags = {
    Name = "ec2-${count.index}${var.root-name}"
  }
}

// Data request that will get the AMI of the Ubuntu 20.04 LTS OS for the defined AWS Region
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "sanity" {
  ami                         = "ami-0ed752ea0f62749af"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ec2-sg.id, aws_security_group.sanity-sg.id]
  key_name                    = aws_key_pair.ssh_key.key_name
  subnet_id                   = aws_subnet.public[0].id
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
    Name = "ec2-sanity${var.root-name}"
  }
}
