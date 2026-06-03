# SSH Key Pair Generation
resource "tls_private_key" "vm_key" { algorithm = "ED25519" }

resource "aws_key_pair" "deployer_key" {
  key_name   = "devOps-key"
  public_key = tls_private_key.vm_key.public_key_openssh
}

resource "local_file" "private_key_pem" {
  content         = tls_private_key.vm_key.private_key_openssh
  filename        = "${path.module}/../../devOps-key.pem"
  file_permission = "0600"
}