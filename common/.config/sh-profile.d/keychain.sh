#!/usr/bin/env bash

if [[ -f /usr/bin/keychain ]]; then
    # shellcheck disable=SC2312
    eval "$(keychain --eval --agents ssh --quiet --quick id_rsa)"
fi
