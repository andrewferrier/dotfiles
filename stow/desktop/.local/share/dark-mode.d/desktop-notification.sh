#!/usr/bin/env bash

set -o errexit
set -o noglob
set -o nounset
set -o pipefail

MODE_NAME=${MODE_NAME:-"dark"}

"${HOME}/.local/bin/common-dotfiles/notify" --severity 3 "Switching to ${MODE_NAME} mode."
