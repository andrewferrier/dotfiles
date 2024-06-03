#!/usr/bin/env bash

set -o errexit
set -o noglob
set -o nounset
set -o pipefail

shopt -s inherit_errexit

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    gsettings set org.gnome.desktop.interface gtk-theme Adwaita
    echo 'Adwaita' >"$HOME/.config/gtk-2.0/gtkrc2"
    printf "[Settings]\nAdwaita\n" >"$HOME/.config/gtk-3.0/settings.ini"
fi
