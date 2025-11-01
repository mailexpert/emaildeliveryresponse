# 📬 Email Deliverability Network

**Crowd-powered, privacy-preserving intelligence for email deliverability.**

This open-source project aims to build a global, anonymized repository of email deliverability insights—gathered from real-world bounce logs and SMTP responses—while ensuring privacy by storing only **hashed email addresses (SHA-256)**.

## 🔍 Why This Project?

Traditional email validation tools operate in silos. We believe that:
- Deliverability data should be **open**, not hoarded
- Email addresses should never be exposed or sold
- Everyone benefits when bounce logs are shared transparently

This platform enables **developers, ESPs, marketers, and sysadmins** to contribute to and benefit from a **shared knowledge base of hashed email results**, without compromising user privacy.

## 🧱 How It Works

- Submit email deliverability data with **hashed email addresses** (SHA-256)
- Store related metadata such as:
  - SMTP status codes
  - Bounce type (hard/soft)
  - Source verification
  - Last seen date
- Access deliverability status of any email (by hash) through a web UI or API
- Web UI Interface: https://emaildelivery.space/

## 📦 Features

- ✅ One-way hashed email submissions (privacy-friendly)
- 🌐 REST-style API (via WSGI or Flask)
- 📄 Web UI to check single or batch email hashes
- 🔁 Bulk CSV upload + result download
- 🛡️ Duplicate and spam submission checks
- 🔍 Open and extensible JSON-based schema

## ⚠️ We Never Store:
- Plaintext email addresses  
- IPs of submitters  
- Personally identifiable information (PII)

This is a **community-driven effort**, not a commercial validator.

## 🚀 Get Started

### 🖥️ Run Locally
```bash
git clone https://github.com/your-org/email-hash-network.git
cd email-hash-network
pip install -r requirements.txt
python email_hash_web_ui.py
```

### 🌐 Access:
- Web UI: http://emaildelivery.space
- API: `/check/{email_hash}`, `/submit`, `/batch`

For testing sample data, use the following email addresses:
#### Successful Delivery examples
successful1@gmail.com   
successful2@gmail.com   
successful3@gmail.com   

#### Soft Bounce examples
domainnotfound1@gmail.come  
domainnotfound2@gmail.come  
inboxfull1@gmail.com  
inboxfull2@gmail.com  
unabletofindmxofdomain1@gmail.comm  
unabletofindmxofdomain2@gmail.comm  
accountinactive1@gmail.com  
accountinactive2@gmail.com  

#### Hard Bounce examples
accountnotexists1@gmail.com  
accountnotexists2@gmail.com  
mailboxunavailable1@mail.com  
mailboxunavailable2@mail.com  
mailboxdisabled1@rocketmail.com  
mailboxdisabled2@rocketmail.com  

## 🤝 Contributing

We welcome data contributions from:
- ESPs and SMTP administrators
- Email marketers & campaign managers
- Developers of email validation tools
- Security researchers and email analysts

### Submit Data (via API):
```json
POST /submit
{
  "email": "fromname@test.com",
  "send_date": "2025-11-01 02:34:22",
  "hard_bounce_date": null,
  "hard_bounce_reason": null,
  "soft_bounce_date": "2025-11-01 02:34:48",
  "soft_bounce_reason": "Mailbox does not exist",
  "smtp_code": "550",
  "smtp_message": "Mailbox not found",
  "delivered_date": null,
  "status": "failed"
}
```

## Data Privacy & PII Handling

This project processes email-related activity data for the purpose of recipient-level deliverability scoring.  
To support accurate cross-campaign and cross-source attribution, the API accepts **raw email addresses** as input.

However, we follow a **zero-retention PII policy**:

- **Raw email addresses are never stored** in any database.
- Raw values are **never written to logs**, debug output, or telemetry.
- The raw input is used **only in-memory** for:
  - Email format validation
  - Domain normalization (e.g., IDNA / unicode-safe handling)
  - Converting the address into a **normalized, one-way SHA-256 hash**

Once the hash is generated, the raw email value is **immediately discarded** and does **not persist** past the ingestion step.

Only the hashed identifier is stored for event attribution and behavioral analysis.

This design ensures:

- Accurate recipient history and scoring
- Cross-source deduplication
- Strong privacy protection
- **No storage of Personally Identifiable Information (PII)**

> **In short:** The system processes raw email only long enough to turn it into a hash — and does not store, retain, or log the raw address at any point.

### Example Data Flow

Client sends raw email
↓
Validate & normalize
↓
Convert to SHA-256 hash
↓
Store only the hash
↓
Discard raw email entirely


### Why Hashing Is Used

The hashed email address acts as a stable, anonymous identifier that:
- Cannot be reverse-engineered to reveal the original email address
- Enables behavioral modeling while respecting privacy
- Supports deduplication across data sources

### Privacy Statement

We are committed to protecting user privacy.  
All processing is performed under the principle of **minimum necessary retention** — raw PII is never stored.


📬 *You can also batch submit via CSV or contribute via pull request.*

## 📜 License

MIT License – use freely, improve openly..

## 🙌 Acknowledgments

This project is inspired by the idea that **open email infrastructure = better email ecosystems**. Special thanks to everyone helping make the email world more transparent and secure.


