#!/usr/bin/env bash

set -o errexit
set -o noglob
set -o nounset
set -o pipefail

shopt -s inherit_errexit

THEME_NAME=${1:-Adwaita-dark}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    gsettings set org.gnome.desktop.interface gtk-theme "${THEME_NAME}"
    echo "${THEME_NAME}" >"$HOME/.config/gtk-2.0/gtkrc2"
    printf "[Settings]\n%s\n" "${THEME_NAME}" >"$HOME/.config/gtk-3.0/settings.ini"
fi
