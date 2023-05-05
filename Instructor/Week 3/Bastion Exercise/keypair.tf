resource "tls_private_key" "instance_pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_private_key" "bastion_pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "instance_key_pair" {
  key_name   = "bradt_instance_key_pair"
  public_key = tls_private_key.instance_pk.public_key_openssh

   provisioner "local-exec" {
    command = "echo '${tls_private_key.instance_pk.private_key_pem}' > ~/.ssh/aws_public_instance.pem"
    }
}

resource "aws_key_pair" "bastion_key_pair" {
  key_name   = "bradt_bastion_key_pair"
  public_key = tls_private_key.bastion_pk.public_key_openssh

   provisioner "local-exec" {
    command = "echo '${tls_private_key.bastion_pk.private_key_pem}' > ~/.ssh/aws_public_bastion.pem"
    }
}