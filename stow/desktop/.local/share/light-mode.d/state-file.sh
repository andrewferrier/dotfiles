#!/usr/bin/env bash

set -o errexit
set -o noglob
set -o nounset
set -o pipefail

shopt -s inherit_errexit

echo 'day' > "$HOME/.cache/day-night/state-terminal"
