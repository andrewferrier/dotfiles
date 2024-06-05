#!/usr/bin/env bash

set -o errexit
set -o noglob
set -o nounset
set -o pipefail

shopt -s inherit_errexit

THEME_NAME=${1:-Adwaita-dark}
DARK_INT=${2:-1}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "gtk-theme-name=\"${THEME_NAME}\"" >"$HOME/.config/gtk-2.0/gtkrc2"
    printf "[Settings]\ngtk-theme-name=%s\ngtk-application-prefer-dark-theme=%s\n" "${THEME_NAME}" "${DARK_INT}" >"$HOME/.config/gtk-3.0/settings.ini"
fi
