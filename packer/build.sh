#!/bin/bash
set -euo pipefail

echo "Running packer build..."
packer build airplane-ami.json
AMI_US_WEST_2="$(jq -r '.builds[-1].artifact_id' manifest.json | cut -d ":" -f2)"
IMAGE_NAME="$(aws ec2 describe-images --image-id "${AMI_US_WEST_2}" | jq -r '.Images[0].Name')"
echo "Built image ${IMAGE_NAME} in us-west-2: ${AMI_US_WEST_2}"

echo "Copying to us-east-1..."
AMI_US_EAST_1="$(aws ec2 copy-image \
    --source-image-id "${AMI_US_WEST_2}" --source-region us-west-2 \
    --region us-east-1 --name "${IMAGE_NAME}" | jq -r .ImageId)"
echo "Copied AMI in us-east-1: ${AMI_US_EAST_1}"

echo "Copying to eu-west-1..."
AMI_EU_WEST_1="$(aws ec2 copy-image \
    --source-image-id "${AMI_US_WEST_2}" --source-region us-west-2 \
    --region eu-west-1 --name "${IMAGE_NAME}" | jq -r .ImageId)"
echo "Copied AMI in eu-west-1: ${AMI_EU_WEST_1}"

echo ""
echo "Images built:"
echo "eu-west-1: ${AMI_EU_WEST_1}"
echo "us-east-1: ${AMI_US_EAST_1}"
echo "us-west-2: ${AMI_US_WEST_2}"
