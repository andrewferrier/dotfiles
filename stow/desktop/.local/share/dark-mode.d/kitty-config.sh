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
env FZF_DEFAULT_OPTS=${FZF_COLORS}
env BAT_THEME=gruvbox-${MODE}
EOF

# If kitty-themes are already downloaded, don't look again, because this can
# fail, e.g. on resume when the internet connection isn't up yet.
if [[ -f ~/.cache/kitty/kitty-themes.zip ]]; then
    kitty +kitten themes --reload-in=all --cache-age=-1 --config-file-name=themes.conf "colors-${MODE}"
else
    kitty +kitten themes --reload-in=all --config-file-name=themes.conf "colors-${MODE}"
fi
