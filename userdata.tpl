Content-Type: multipart/mixed; boundary="==BOUNDARY=="
MIME-Version: 1.0
--==BOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"
#!/bin/bash -xv
AP_AGENT_NAME="TODO_AGENT_NAME" \
AP_API_HOST="${api_host}" \
AP_API_TOKEN="${api_token}" \
AP_TEAM_ID="${team_id}" \
/usr/local/bin/configure-airplane.sh
--==BOUNDARY==
