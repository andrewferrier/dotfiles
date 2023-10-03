#!/usr/bin/env bash

if (command -v eza >/dev/null 2>&1); then
    alias ls="eza --time-style=long-iso --binary --group-directories-first --group --classify --hyperlink --mounts --extended"
elif (command -v exa >/dev/null 2>&1); then
    alias ls="exa --time-style=long-iso --binary --group-directories-first --group --classify"
fi
