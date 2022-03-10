# NTTDATA - DIGITAL ARCHITECTURE - ENGENIEER
# Create: Marcos Cianci - mlopesci@emeal.nttdata.com
# Date: Qua 9 Mar 2022
# Terraform Module - AWS EC2 - KEY PAIR


resource "aws_key_pair" "keypair" {

    key_name    = "${var.ec2_name}${terraform.workspace}"
    public_key  = tls_private_key.tls.public_key_openssh

    tags = {
        Name    = "${var.ec2_name}${terraform.workspace}"
        Env     = terraform.workspace 
    }
}

resource "tls_private_key" "tls" {
    algorithm = "RSA"
}

resource "local_file" "key" {

    content = tls_private_key.tls.private_key_pem
    filename = "${var.ec2_name}${terraform.workspace}.pem"

    provisioner "local-exec" {
        command = "chmod 400 ${var.ec2_name}${terraform.workspace}.pem"
    }
}