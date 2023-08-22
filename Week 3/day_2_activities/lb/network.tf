resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "vpc-gateway-rory"
  }

}
/*
resource "aws_eip_association" "eip_assoc" {
  count         = 1
  instance_id   = aws_instance.app_server[count.index].id
  allocation_id = aws_eip.eip[count.index].id
}

resource "aws_eip" "eip" {
  count    = 1
  instance = aws_instance.app_server[count.index].id
  vpc      = true

  depends_on = [aws_internet_gateway.gateway]
  tags = {
    Name = "rl_EC2_eip"
  }
}
*/