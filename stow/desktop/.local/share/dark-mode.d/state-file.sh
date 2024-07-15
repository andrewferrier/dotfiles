#!/usr/bin/env bash

set -o errexit
set -o noglob
set -o nounset
set -o pipefail

XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"

STATE="${STATE:-night}"

echo "$STATE" > "${XDG_CACHE_HOME}/day-night/state"
