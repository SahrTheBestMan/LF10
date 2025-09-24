az vm run-command invoke \
  --command-id RunShellScript \
  --name VM02 \
  --resource-group LF10-SQ-VT \
  --scripts @- <<'EOF'
# create /opt/cleanup.sh 
cat > /opt/cleanup.sh <<'EOL'
#!/bin/bash
echo "Cleanup script is running $(date)" >> /tmp/cleanup.log
EOL

chmod +x /opt/cleanup.sh

# service file creation
cat > /etc/systemd/system/vm-cleanup.service <<'EOL'
[Unit]
Description=Runs Cleanup Script
[Service]
ExecStart=/bin/bash /opt/cleanup.sh
EOL

# timer file creation
cat > /etc/systemd/system/vm-cleanup.timer <<'EOL'
[Unit]
Description=Runs Cleanup Script hourly
[Timer]
OnBootSec=5min
OnUnitActiveSec=1h
[Install]
WantedBy=timers.target
EOL

# reload systemd and activate timer
systemctl daemon-reload
systemctl enable vm-cleanup.timer
systemctl start vm-cleanup.timer
EOF

