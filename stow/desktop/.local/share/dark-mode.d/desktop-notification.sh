#!/usr/bin/env bash

set -o errexit
set -o noglob
set -o nounset
set -o pipefail

shopt -s inherit_errexit

MODE_NAME=${1:-dark}
"${HOME}/.local/bin/common-dotfiles/notify" --severity 3 "Switching to ${MODE_NAME} mode."
