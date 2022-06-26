#!/usr/bin/env bash

# Some commands (e.g. abcde) don't use VISUAL properly, so EDITOR is needed.
VISUAL=$(command -v nvim)
export VISUAL
EDITOR=${VISUAL}
export EDITOR
