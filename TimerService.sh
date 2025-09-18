az vm run-command invoke \
  --command-id RunShellScript \
  --name VM02 \
  --resource-group LF10-SQ-VT \
  --scripts @- <<'EOF'
# /opt/cleanup.sh anlegen
cat > /opt/cleanup.sh <<'EOL'
#!/bin/bash
echo "Cleanup Script läuft $(date)" >> /tmp/cleanup.log
EOL

chmod +x /opt/cleanup.sh

# Service-Datei erstellen
cat > /etc/systemd/system/vm-cleanup.service <<'EOL'
[Unit]
Description=Runs Cleanup Script
[Service]
ExecStart=/bin/bash /opt/cleanup.sh
EOL

# Timer-Datei erstellen
cat > /etc/systemd/system/vm-cleanup.timer <<'EOL'
[Unit]
Description=Runs Cleanup Script hourly
[Timer]
OnBootSec=5min
OnUnitActiveSec=1h
[Install]
WantedBy=timers.target
EOL

# Systemd neu laden und Timer aktivieren
systemctl daemon-reload
systemctl enable vm-cleanup.timer
systemctl start vm-cleanup.timer
EOF
