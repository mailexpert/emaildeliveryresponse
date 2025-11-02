import hashlib
import requests
import sys

# Check if correct number of arguments provided
if len(sys.argv) != 3:
    print("Usage: python check_email_deliverability.py <email> <bearer_token>")
    sys.exit(1)

# Get email and bearer token from command line arguments
email = sys.argv[1]
bearer_token = sys.argv[2]

# Hash the email using SHA-256
email_hash = hashlib.sha256(email.encode('utf-8')).hexdigest()

# Set the API endpoint
api_url = f"http://emaildelivery.space/me/check/{email_hash}"

# Set up headers with Bearer token
headers = {
    "Authorization": f"Bearer {bearer_token}"
}

# Send GET request with authentication
print(f"Checking: {email} (hashed: {email_hash})")
response = requests.get(api_url, headers=headers)

# Print result
if response.status_code == 200:
    print("Result:", response.json())
else:
    print(f"Error {response.status_code}: {response.text}")
