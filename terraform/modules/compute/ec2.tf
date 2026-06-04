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

resource "aws_instance" "devOps_webserver" {
  ami                   = data.aws_ami.ubuntu.id
  instance_type         = var.instance_type
  subnet_id             = var.pub_subnet_id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  key_name              = aws_key_pair.deployer_key.key_name
  iam_instance_profile  = data.aws_iam_instance_profile.labInstanceProfile.name
  root_block_device {
    volume_size = 20
  }

  tags = { Name = "devOps-webserver" }

  # Connection block tells the provisioner how to SSH into the box
  # connection {
  #   type        = "ssh"
  #   user        = "ubuntu"
  #   private_key = tls_private_key.vm_key.private_key_openssh
  #   host        = self.public_ip
  # }

# Executes the bash script seamlessly on startup
  user_data = <<-EOF
              #!/bin/bash
              # Redirect all output to a log file for runtime debugging
              exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/null) 2>&1

              echo "=== Starting User Data Script ==="

              # Update the local package manager index
              apt-get update -y

              # Install the full OpenJDK 21 Development Kit
              apt-get install openjdk-21-jdk -y

              # Print versions to log to verify successful deployment
              java -version
              javac -version

              echo "=== User Data Script Completed ==="
              EOF

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