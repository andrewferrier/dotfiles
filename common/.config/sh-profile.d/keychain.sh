#!/usr/bin/env bash

if [[ -f /usr/bin/keychain ]]; then
    eval "$(keychain --eval --agents ssh --quiet --quick id_rsa)"
fi
