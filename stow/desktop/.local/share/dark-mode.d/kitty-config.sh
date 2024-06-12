#!/usr/bin/env bash

set -o errexit
set -o noglob
set -o nounset
set -o pipefail

shopt -s inherit_errexit

source "${HOME}/.config/sh-profile.d/misc-env-vars.sh"

MODE=${1:-dark}
FZF_COLORS=${2:-$FZF_DEFAULT_OPTS_DARK_COLORS}

KITTY_TRANSIENT="${HOME}/.config/kitty/transient.conf"

cat << EOF > "$KITTY_TRANSIENT"
include ~/.config/kitty/colors-${MODE}.conf
env FZF_DEFAULT_OPTS=${FZF_COLORS}
env BAT_THEME=gruvbox-${MODE}
EOF
