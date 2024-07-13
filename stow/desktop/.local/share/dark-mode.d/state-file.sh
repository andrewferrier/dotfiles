#!/usr/bin/env bash

set -o errexit
set -o noglob
set -o nounset
set -o pipefail

STATE="${STATE:-night}"

echo "$STATE" > "$HOME/.cache/day-night/state"
