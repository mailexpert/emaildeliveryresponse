import hashlib
import requests

# Sample email address
email = "example@example.com"

# Hash the email using SHA-256
email_hash = hashlib.sha256(email.encode('utf-8')).hexdigest()

# Set the API endpoint
api_url = f"http://emaildelivery.space/me/check/{email_hash}"

# Send GET request
print(f"Checking: {email} (hashed: {email_hash})")
response = requests.get(api_url)

# Print result
if response.status_code == 200:
    print("Result:", response.json())
else:
    print(f"Error {response.status_code}: {response.text}")

