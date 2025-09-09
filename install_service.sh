#!/bin/sh

SERVICE_FILE="/etc/systemd/system/airraid.service"

SERVICE_CONTENT="[Unit]
Description=AirRaid Application
After=network.target

[Service]
Type=simple
Environment=\"API_KEYS=foo\"
ExecStart=/usr/bin/make run
WorkingDirectory=/root/raid
StandardOutput=append:/root/raid.log
StandardError=append:/root/raid.log
Restart=always
User=root

[Install]
WantedBy=multi-user.target
"

echo "$SERVICE_CONTENT" > "$SERVICE_FILE"


touch /root/raid.log
chmod 600 /root/raid.log

systemctl daemon-reload
systemctl enable airraid.service
systemctl start airraid.service
systemctl status airraid.service

curl 127.0.0.1:10101/api/states -H 'X-API-Key: foo'
