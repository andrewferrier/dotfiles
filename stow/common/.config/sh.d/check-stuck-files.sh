#!/usr/bin/env bash

set -o nounset

if [[ -f ${HOME}/.local/bin/common/check-stuck-files ]]; then
    "${HOME}/.local/bin/common/check-stuck-files"
fi
