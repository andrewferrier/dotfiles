#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC1091
source "${HOME}/.config/sh-profile.d/misc-env-vars.sh"

for file in "${HOME}"/.local/share/dark-mode.d/*.sh; do
    echo "Running ${file} from $0"

    # shellcheck source=/dev/null disable=SC2154
    DARK_INT=0 \
        FZF_COLORS="${FZF_DEFAULT_OPTS_LIGHT_COLORS}" \
        MODE_NAME="light" \
        STATE="day" \
        THEME_NAME="Adwaita" \
        source "${file}"
done
