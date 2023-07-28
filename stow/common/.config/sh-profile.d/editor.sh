#!/usr/bin/env bash

# Some commands (e.g. abcde) don't use VISUAL properly, so EDITOR is needed.

if command -v nvim >/dev/null 2>/dev/null; then
    VISUAL=$(command -v nvim)
else
    VISUAL=$(command -v vim)
fi

export VISUAL
EDITOR=${VISUAL}
export EDITOR
