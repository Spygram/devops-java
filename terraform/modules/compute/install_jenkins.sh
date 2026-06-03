#!/bin/bash
# modules/compute/install_jenkins.sh

# Exit immediately if a command exits with a non-zero status
set -e

# 1. Update the system package index
sudo apt-get update -y

# Follow the official Jenkins installation guide for Debian/Ubuntu (README.md for the link)

sudo apt install  -y fontconfig openjdk-21-jre

sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y

sudo apt install jenkins -y

sudo systemctl enable jenkins
sudo systemctl start jenkins
