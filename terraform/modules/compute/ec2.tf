# Public VM with Jenkins Remote Provisioner
resource "aws_instance" "jenkins_master" {
  ami                   = data.aws_ami.ubuntu.id
  instance_type         = var.instance_type
  subnet_id             = var.pub_subnet_id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  key_name              = aws_key_pair.deployer_key.key_name
  iam_instance_profile  = data.aws_iam_instance_profile.labInstanceProfile.name
  root_block_device {
    volume_size = 20
  }

  tags = { Name = "devOps-jenkins-master" }

  # Connection block tells the provisioner how to SSH into the box
  # connection {
  #   type        = "ssh"
  #   user        = "ubuntu"
  #   private_key = tls_private_key.vm_key.private_key_openssh
  #   host        = self.public_ip
  # }

# Executes the bash script seamlessly on startup
  user_data = templatefile("${path.module}/install_jenkins.sh", {})

  user_data_replace_on_change = true
  # provisioner "file" {
  #   source      = "${path.module}/install_jenkins.sh"
  #   destination = "/tmp/install_jenkins.sh"
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /tmp/install_jenkins.sh",
  #     "/tmp/install_jenkins.sh",
  #     "cat /var/lib/jenkins/secrets/initialAdminPassword"
  #   ]
  # }
}

resource "aws_instance" "jenkins_slave" {
  ami                   = data.aws_ami.ubuntu.id
  instance_type         = var.instance_type
  subnet_id             = var.pub_subnet_id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  key_name              = aws_key_pair.deployer_key.key_name
  iam_instance_profile  = data.aws_iam_instance_profile.labInstanceProfile.name
  root_block_device {
    volume_size = 20
  }

  tags = { Name = "devOps-jenkins-slave" }

  # Connection block tells the provisioner how to SSH into the box
  # connection {
  #   type        = "ssh"
  #   user        = "ubuntu"
  #   private_key = tls_private_key.vm_key.private_key_openssh
  #   host        = self.public_ip
  # }

# Executes the bash script seamlessly on startup
  user_data = templatefile("${path.module}/install_jenkins.sh", {})

  user_data_replace_on_change = true
  # provisioner "file" {
  #   source      = "${path.module}/install_jenkins.sh"
  #   destination = "/tmp/install_jenkins.sh"
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /tmp/install_jenkins.sh",
  #     "/tmp/install_jenkins.sh",
  #     "cat /var/lib/jenkins/secrets/initialAdminPassword"
  #   ]
  # }
}