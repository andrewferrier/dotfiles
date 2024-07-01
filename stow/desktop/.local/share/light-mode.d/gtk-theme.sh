#!/usr/bin/env bash

set -o errexit
set -o noglob
set -o nounset
set -o pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
"${SCRIPT_DIR}/../dark-mode.d/gtk-theme.sh" Adwaita "0"
