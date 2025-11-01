#!/bin/bash

# Usage: ./check_email.sh someone@example.com

if [ -z "$1" ]; then
  echo "Usage: $0 <email-address>"
  exit 1
fi

EMAIL="$1"
EMAIL_HASH=$(echo -n "$EMAIL" | sha256sum | awk '{print $1}')
API_URL="https://emaildelivery.space/me/check/$EMAIL_HASH"

echo "Checking deliverability for: $EMAIL"
echo "Email SHA-256 hash: $EMAIL_HASH"
echo "Querying API at: $API_URL"

TMP_FILE=$(mktemp)
HTTP_STATUS=$(curl -s -w "%{http_code}" -o "$TMP_FILE" "$API_URL")

if [ "$HTTP_STATUS" -eq 200 ]; then
  if jq -e . >/dev/null 2>&1 < "$TMP_FILE"; then
    cat "$TMP_FILE" | jq
  else
    echo "Error: Response is not valid JSON:"
    cat "$TMP_FILE"
  fi
else
  echo "Error: Received HTTP status $HTTP_STATUS"
  cat "$TMP_FILE"
fi

rm -f "$TMP_FILE"

