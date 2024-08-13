#!/usr/bin/env bash

set -o errexit
set -o noglob
set -o nounset
set -o pipefail

MODE_NAME=${MODE_NAME:-"dark"}

MESSAGE="Switching to ${MODE_NAME} mode."

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    notify-send --urgency low "${MESSAGE}"
else
    osascript -e "display notification \"${MESSAGE}\" with title \"Mode switcher\""
fi
