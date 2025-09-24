#!/bin/bash

ALERT_EMAIL="lf8gruppe3@gmail.com"
SMTP_USER="lf8gruppe3@gmx.de"
SMTP_PASS="SYRIXUFFYUO2J5W3SZNN"
HOSTNAME=$(hostname)

# enable logging
LOG_FILE="/tmp/cleanup_script.log"
exec > >(tee -a "$LOG_FILE") 2>&1

echo "Script started at $(date)"

# check if curl is installed
if ! command -v curl &> /dev/null; then
    echo " curl installed."
    apt-get update
    apt-get install -y curl
fi

DISK_BEFORE=$(df -B1 / | awk 'NR==2 {print $4}')

# cleanup 
echo "Starting cleanup..."
apt-get clean
apt-get autoremove -y --purge
rm -rf /var/lib/apt/lists/*

journalctl --vacuum-time=7d 2>/dev/null || echo "Journal cleanup nicht verfügbar"
rm -rf /tmp/* /var/tmp/*

for dir in /home/*; do
    if [ -d "$dir" ]; then
        [ -d "$dir/Downloads" ] && rm -rf "$dir/Downloads/"*
        [ -d "$dir/.cache" ] && rm -rf "$dir/.cache/"*
        echo "Cleaned user directory: $dir"
    fi
done

[ -d /root/Downloads ] && rm -rf /root/Downloads/*
[ -d /root/.cache ] && rm -rf /root/.cache/*

# check
DISK_AFTER=$(df -B1 / | awk 'NR==2 {print $4}')
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
DISK_FREED=$(( (DISK_AFTER - DISK_BEFORE) / 1024 / 1024 ))

echo "Disk before: $DISK_BEFORE bytes"
echo "Disk after: $DISK_AFTER bytes"
echo "Disk usage: $DISK_USAGE%"
echo "Freed: $DISK_FREED MB"

# email
send_mail() {
    SUBJECT=$1
    BODY=$2
    
    echo "Attempting to send email: $SUBJECT"
    
    MAIL_FILE=$(mktemp)
    cat > "$MAIL_FILE" << EOM
From: $SMTP_USER
To: $ALERT_EMAIL
Subject: $SUBJECT
Date: $(date -R)

$BODY
EOM

    RESULT=$(curl -s -v --url 'smtps://mail.gmx.net:465' \
        --ssl-reqd \
        --mail-from "$SMTP_USER" \
        --mail-rcpt "$ALERT_EMAIL" \
        --user "$SMTP_USER:$SMTP_PASS" \
        --upload-file "$MAIL_FILE" 2>&1)
    
    echo "Curl result: $RESULT"
    rm -f "$MAIL_FILE"
}

# alert
echo "Checking disk usage for alert..."
if [ "$DISK_USAGE" -ge 1 ]; then
    echo "Disk usage is $DISK_USAGE%, sending alert..."
    send_mail "ALERT: Ubuntu VM $HOSTNAME Disk Usage" \
    "Festplattennutzung auf $HOSTNAME: ${DISK_USAGE}%

Frei gemacht: $DISK_FREED MB
Zeit: $(date)"
else
    echo "Disk usage is acceptable ($DISK_USAGE%), no alert needed."
fi

echo "Script completed at $(date)"


