#!/usr/bin/env bash

set -o errexit
set -o noglob
set -o nounset
set -o pipefail

THEME_NAME=${THEME_NAME:-"Adwaita-dark"}
DARK_INT=${DARK_INT:-1}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    mkdir -p \
        "$HOME/.config/gtk-2.0" \
        "$HOME/.config/gtk-3.0"

    echo "gtk-theme-name=\"${THEME_NAME}\"" >"$HOME/.config/gtk-2.0/gtkrc2"
    printf "[Settings]\ngtk-theme-name=%s\ngtk-application-prefer-dark-theme=%s\n" "${THEME_NAME}" "${DARK_INT}" >"$HOME/.config/gtk-3.0/settings.ini"
    xfconf-query -c xsettings -p /Net/ThemeName -s "${THEME_NAME}"
fi
