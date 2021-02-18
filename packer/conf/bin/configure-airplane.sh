#!/bin/bash
set -euo pipefail

INSTANCE_ID="$(/opt/aws/bin/ec2-metadata --instance-id | cut -d " " -f 2)"
AWS_REGION="$(curl --silent http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region)"
AWS_ACCOUNT_ID="$(curl --silent http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .accountId)"

cat << EOF > /etc/airplane-agent/airplane-agent.env
AP_AGENT_NAME=${INSTANCE_ID}-%s
AP_API_HOST=${AP_API_HOST}
AP_API_TOKEN=${AP_API_TOKEN}
AP_TEAM_ID=${AP_TEAM_ID}
AP_LABELS=cloud:aws aws_instance_id:${INSTANCE_ID} aws_region:${AWS_REGION} aws_account_id:${AWS_ACCOUNT_ID} ${AP_LABELS}
EOF

chown airplane-agent: /etc/airplane-agent/airplane-agent.env

# Wait for Docker
next_wait_time=0
until docker ps || [ $next_wait_time -eq 5 ]; do
	sleep $(( next_wait_time++ ))
done

if ! docker ps ; then
  echo "Failed to contact docker"
  exit 1
fi

systemctl enable "airplane-agent"
systemctl start "airplane-agent"
