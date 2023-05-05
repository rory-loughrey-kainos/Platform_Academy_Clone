# Creating security group for Bastion Host/Jump Box
resource "aws_security_group" "bradt_bh_sg" {

  depends_on = [
    aws_vpc.bradt_vpc,
    aws_subnet.bradt_public_subnet,
    aws_subnet.bradt_private_subnet
  ]

  description = "Bastion Host SG"
  name = "bastion-host-sg"
  vpc_id = aws_vpc.bradt_vpc.id

  # Created an inbound rule for Bastion Host SSH
  ingress {
    description = "Bastion Host SG"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "output from Bastion Host"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}