output "web_instance_ip" {
  value = aws_instance.rory_ec2.public_ip
}

output "elastic-ip" {
  value = aws_eip.eip
}