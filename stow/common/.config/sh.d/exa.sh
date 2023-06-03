#!/usr/bin/env bash

if (command -v exa >/dev/null 2>&1); then
    alias ls="exa --time-style=long-iso --binary --group-directories-first --group --classify"
fi
