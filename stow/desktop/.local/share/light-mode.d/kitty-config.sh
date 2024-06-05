#!/usr/bin/env bash

source "${HOME}/.config/sh-profile.d/misc-env-vars.sh"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
"${SCRIPT_DIR}/../dark-mode.d/kitty-config.sh" light "$FZF_LIGHT_COLORS"
