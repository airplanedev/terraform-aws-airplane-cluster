#!/bin/bash
set -euo pipefail

echo "Creating airplane-agent user and group..."
sudo useradd --base-dir /var/lib --uid 2000 airplane-agent
sudo usermod -a -G docker airplane-agent

echo "Creating configuration dir..."
sudo mkdir -p /etc/airplane-agent
sudo chown -R airplane-agent: /etc/airplane-agent

echo "Copying bin over..."
sudo chmod +x /tmp/conf/bin/*
sudo mv /tmp/conf/bin/* /usr/local/bin

echo "Adding systemd service..."
sudo cp /tmp/conf/airplane-agent.service /etc/systemd/system/airplane-agent.service
