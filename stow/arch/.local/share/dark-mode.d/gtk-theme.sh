#!/usr/bin/env bash

set -o errexit
set -o noglob
set -o nounset
set -o pipefail

shopt -s inherit_errexit

gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
echo 'Adwaita-dark' > "$XDG_CONFIG_HOME/gtk-2.0/gtkrc2"
printf "[Settings]\nAdwaita-dark\n" > "$XDG_CONFIG_HOME/gtk-3.0/settings.ini"
