#!/usr/bin/env bash

set -o errexit
set -o noglob
set -o nounset
set -o pipefail

shopt -s inherit_errexit

echo 'include ~/.config/kitty/colors-dark.conf' > "$HOME/.cache/day-night/kitty-color.conf"
