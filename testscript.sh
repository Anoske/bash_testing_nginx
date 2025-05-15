#!/bin/bash

LOGFILE="/opt/nginxstatus.log"
CURRENT_PID=$(systemctl show nginx --property=ExecMainPID | cut -d'=' -f2)

if systemctl is-active --quiet nginx; then
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:80)
    echo "$(date '+%Y-%m-%d %H:%M:%S') Nginx запущен (PID: $CURRENT_PID, HTTP: $STATUS)." >> "$LOGFILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') ВНИМАНИЕ: Nginx отключен!" >> "$LOGFILE"
fi

