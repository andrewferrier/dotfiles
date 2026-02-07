#!/usr/bin/env bash

if (command -v uv >/dev/null 2>&1); then
    alias uv-clean-pip="uv pip list --format json | jq -r '.[].name' | fzf -m --reverse | xargs -n 1 uv pip uninstall"
    alias uv-clean-tools="uv tool list | grep -v '^-' | cut -d' ' -f1 | fzf -m --reverse | xargs -n 1 uv tool uninstall"
fi
