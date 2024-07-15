#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-${HOME}/.cache/xdg-runtime}"

MODE_NAME=${MODE_NAME:-"dark"}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    cp "${XDG_CONFIG_HOME}/i3/i3-${MODE_NAME}-colors.conf" "${XDG_CACHE_HOME}/day-night/i3-colors.conf"
    i3-msg -s "${XDG_RUNTIME_DIR}"/i3/ipc-socket.* reload
fi
