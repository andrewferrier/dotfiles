#!/usr/bin/env bash

set -o errexit
set -o noglob
set -o nounset
set -o pipefail

shopt -s inherit_errexit

source "${HOME}/.config/sh-profile.d/misc-env-vars.sh"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
"${SCRIPT_DIR}/../dark-mode.d/kitty-config.sh" light "$FZF_DEFAULT_OPTS_LIGHT_COLORS"
