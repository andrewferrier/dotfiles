#!/usr/bin/env bash
# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>

# 10-minute average
UPTIME=$(sysctl -n vm.loadavg | cut -d' ' -f 3)

if (( $(echo "$UPTIME > 5.00" | bc -l) )); then
    echo -n "⚠️ "
    echo "CPU Load $UPTIME | color=#ff0000"
else
    # Not 100% clear but seems this might be needed to remove display
    echo " "
fi
