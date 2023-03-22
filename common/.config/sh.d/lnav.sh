#!/usr/bin/env bash

if (command -v lnav >/dev/null 2>&1); then
    alias lnav-24h='journalctl -f -o json --output-fields=MESSAGE,PRIORITY,_PID,SYSLOG_IDENTIFIER,_SYSTEMD_UNIT --since "24h ago" | lnav'
fi
