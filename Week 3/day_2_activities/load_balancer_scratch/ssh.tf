resource "aws_key_pair" "ssh_key" {
  key_name   = "rory_key"
  public_key = file(var.ssh_filename)
}