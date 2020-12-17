#!/bin/bash
set -euo pipefail

echo "Installing docker..."
sudo yum update -yq
sudo amazon-linux-extras install docker

echo "Configuring docker..."
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
