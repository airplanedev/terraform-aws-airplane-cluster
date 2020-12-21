#!/bin/bash
set -euo pipefail

echo "Installing utils..."
sudo yum update -yq

echo "Installing jq..."
sudo yum install -yq jq
jq --version
