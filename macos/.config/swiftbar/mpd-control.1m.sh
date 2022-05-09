#!/usr/bin/env bash
# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>

PATH=/usr/local/bin:${PATH}

MPC_OUTPUT=$(mpc)

if [ "$(echo "${MPC_OUTPUT}" | wc -l)" -gt 1 ]; then
    STATUS=$(echo "${MPC_OUTPUT}" | head -2 | tail -1 | sed -e 's/].*$//' | sed -e 's/^\[//')

    if [[ ${STATUS} == "paused" ]]; then
        echo -n "⏸️  "
    else
        echo -n "🎵 "
    fi

    echo "${MPC_OUTPUT}" | head -1 | tr -d '\n'
    echo -n "| length = 60"
    printf "\n"
    echo '---'
    echo 'Open vimpc... | href="hammerspoon://vimpc"'
else
    echo ''
fi
