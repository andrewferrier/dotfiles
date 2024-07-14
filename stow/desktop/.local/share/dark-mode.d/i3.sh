#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

MODE_NAME=${MODE_NAME:-"dark"}

cp "${HOME}/.config/i3/i3-${MODE_NAME}-colors.conf" "${HOME}/.cache/day-night/i3-colors.conf"
i3-msg -s /run/user/1000/i3/ipc-socket.* reload
