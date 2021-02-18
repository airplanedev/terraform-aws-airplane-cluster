Content-Type: multipart/mixed; boundary="==BOUNDARY=="
MIME-Version: 1.0
--==BOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"
#!/bin/bash -xv
AP_API_HOST="${api_host}" \
AP_API_TOKEN="${api_token}" \
AP_TEAM_ID="${team_id}" \
AP_LABELS="${labels}" \
/usr/local/bin/configure-airplane.sh
--==BOUNDARY==
