


// ECS Apache Web Frontend servers that are created in the private subnet in Availibilty Zone A
resource "aws_instance" "web_zone_a" {
  count         = var.instance_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  subnet_id       = var.private_subnet_ids[count.index]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  echo "*** Completed Installing apache2"
  echo "<h1>loading from $(hostname -f)..</h1>" > /var/www/html/index.html
  EOF

  tags = {
    Name = "${local.naming_prefix}-webserver-zone-a-${count.index}"
  }

  lifecycle {
    create_before_destroy = true
  }

}

