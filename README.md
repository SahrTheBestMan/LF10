# Ubuntu Cleanup & Alert Script

## Overview
This project provides an automated **cleanup and disk usage alert script** for Ubuntu virtual machines.  
The script helps to keep systems stable by freeing up space, cleaning temporary files, and notifying IT staff via email if disk usage reaches critical levels.

---

## Features
- Automatic cleanup of:
  - APT cache
  - Old journal logs
  - Temporary directories
  - User downloads and cache folders
- Disk space monitoring before and after cleanup
- Email alert to IT if disk usage exceeds the defined threshold
- Detailed logging

---

## Requirements
- Ubuntu-based system
- `curl` (installed automatically if missing)
- Internet connection for email alerts
- Valid SMTP credentials (in this Script - GMX)

---

## Configuration
Adjust the variables inside `cleanup.sh` as needed:

ALERT_EMAIL="your-alert-recipient@example.com"
SMTP_USER="your-smtp-user@example.com"
SMTP_PASS="your-smtp-password"
