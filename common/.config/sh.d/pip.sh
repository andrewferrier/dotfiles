#!/usr/bin/env bash

if (command -v pip >/dev/null 2>&1); then
    alias pip-clean-packages="pip list --not-required --user | tail +3 | cut -f1 -d' ' | fzf -m --reverse | xargs pip uninstall --yes"
fi
