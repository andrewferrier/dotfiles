#!/usr/bin/env bash

# Run for login shells.

if [ -f "$HOME/.bashrc" ]; then
    # shellcheck source=/dev/null
    source "${HOME}/.bashrc"
else
    echo >&2 "${HOME}/.bashrc not found!"
fi

for file in "${HOME}"/.config/sh-profile.d/*; do
    # shellcheck source=/dev/null
    source "${file}"
done
