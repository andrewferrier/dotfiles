#!/usr/bin/env bash

set -o errexit
set -o noglob
set -o nounset
set -o pipefail

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

THEME_NAME=${THEME_NAME:-"Adwaita-dark"}
DARK_INT=${DARK_INT:-1}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    mkdir -p \
        "${XDG_CONFIG_HOME}/gtk-2.0" \
        "${XDG_CONFIG_HOME}/gtk-3.0"

    echo "gtk-theme-name=\"${THEME_NAME}\"" >"${XDG_CONFIG_HOME}/gtk-2.0/gtkrc2"
    printf "[Settings]\ngtk-theme-name=%s\ngtk-application-prefer-dark-theme=%s\n" "${THEME_NAME}" "${DARK_INT}" >"${XDG_CONFIG_HOME}/gtk-3.0/settings.ini"
    xfconf-query -c xsettings -p /Net/ThemeName -s "${THEME_NAME}"
fi
