#!/usr/bin/env bash

set -o errexit
set -o noglob
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "${HOME}/.config/sh-profile.d/misc-env-vars.sh"

MODE_NAME=${MODE_NAME:-"dark"}
FZF_COLORS=${FZF_COLORS:-$FZF_DEFAULT_OPTS_DARK_COLORS}

KITTY_TRANSIENT="${HOME}/.config/kitty/transient.conf"

cat <<EOF >"$KITTY_TRANSIENT"
env FZF_DEFAULT_OPTS=${FZF_COLORS}
env BAT_THEME=gruvbox-${MODE_NAME}
EOF

if [[ ${OSTYPE} == darwin* ]]; then
    CACHE_DIR="${HOME}/Library/Caches"
else
    CACHE_DIR="${HOME}/.cache"
fi

if [[ -x /opt/homebrew/bin/kitty ]]; then
    KITTY=/opt/homebrew/bin/kitty
else
    KITTY=$(command -v kitty)
fi

# If kitty-themes are already downloaded, don't look again, because this can
# fail, e.g. on resume when the internet connection isn't up yet.
if [[ -f $CACHE_DIR/kitty/kitty-themes.zip ]]; then
    $KITTY +kitten themes --reload-in=all --cache-age=-1 --config-file-name=themes.conf "colors-${MODE_NAME}"
else
    $KITTY +kitten themes --reload-in=all --config-file-name=themes.conf "colors-${MODE_NAME}"
fi
