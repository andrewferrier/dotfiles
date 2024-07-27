#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"

# shellcheck disable=SC1091
source "${XDG_CONFIG_HOME}/sh-profile.d/misc-env-vars.sh"

for file in "${XDG_DATA_HOME}"/dark-mode.d/*.sh; do
    echo "Running ${file} from $0"

    # shellcheck disable=SC2154
    DARK_INT=0 \
        FZF_COLORS="${FZF_DEFAULT_OPTS_LIGHT_COLORS}" \
        MODE_NAME="light" \
        STATE="day" \
        THEME_NAME="Adwaita" \
        "${file}" || true
done
