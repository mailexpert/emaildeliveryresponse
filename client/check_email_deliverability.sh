#!/bin/bash
# Usage: ./check_email.sh someone@example.com [token]

if [ -z "$1" ]; then
  echo "Usage: $0 <email-address> [bearer-token]"
  echo "  If token is not provided, will check for TOKEN environment variable"
  exit 1
fi

EMAIL="$1"
BEARER_TOKEN="${2:-$TOKEN}"

if [ -z "$BEARER_TOKEN" ]; then
  echo "Error: Bearer token required"
  echo "Provide it as second argument or set TOKEN environment variable"
  echo "Usage: $0 <email-address> <bearer-token>"
  echo "  OR:  TOKEN=your_token $0 <email-address>"
  exit 1
fi

EMAIL_HASH=$(echo -n "$EMAIL" | sha256sum | awk '{print $1}')
API_URL="https://emaildelivery.space/me/check/$EMAIL_HASH"

echo "Checking deliverability for: $EMAIL"
echo "Email SHA-256 hash: $EMAIL_HASH"
echo "Querying API at: $API_URL"

TMP_FILE=$(mktemp)
HTTP_STATUS=$(curl -s -w "%{http_code}" -H "Authorization: Bearer $BEARER_TOKEN" -o "$TMP_FILE" "$API_URL")

if [ "$HTTP_STATUS" -eq 200 ]; then
  if jq -e . >/dev/null 2>&1 < "$TMP_FILE"; then
    cat "$TMP_FILE" | jq
  else
    echo "Error: Response is not valid JSON:"
    cat "$TMP_FILE"
  fi
elif [ "$HTTP_STATUS" -eq 401 ]; then
  echo "Error: Unauthorized (HTTP 401)"
  echo "Invalid or missing bearer token"
  cat "$TMP_FILE"
elif [ "$HTTP_STATUS" -eq 402 ]; then
  echo "Error: Rate limit exceeded (HTTP 402)"
  echo "Please contact support to get an API key"
  cat "$TMP_FILE"
elif [ "$HTTP_STATUS" -eq 403 ]; then
  echo "Error: Forbidden (HTTP 403)"
  echo "Insufficient permissions"
  cat "$TMP_FILE"
else
  echo "Error: Received HTTP status $HTTP_STATUS"
  cat "$TMP_FILE"
fi

rm -f "$TMP_FILE"
