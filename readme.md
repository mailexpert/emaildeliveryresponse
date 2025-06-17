# 📬 Email Hash Deliverability Network

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
- Web UI: http://localhost:8000
- API: `/check/{email_hash}`, `/submit`, `/batch`

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
  "email_hash": "9a5e...",
  "status": "undeliverable",
  "smtp_code": "550",
  "smtp_message": "Mailbox not found",
  "last_seen": "2025-06-08",
  "source_verified": true
}
```

📬 *You can also batch submit via CSV or contribute via pull request.*

## 📜 License

MIT License – use freely, improve openly.

## 🙌 Acknowledgments

This project is inspired by the idea that **open email infrastructure = better email ecosystems**. Special thanks to everyone helping make the email world more transparent and secure.

