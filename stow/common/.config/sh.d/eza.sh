#!/usr/bin/env bash

if (command -v eza >/dev/null 2>&1); then
    alias ls="eza --time-style=long-iso --binary --group-directories-first --group --classify --color-scale --git --git-repos --hyperlink --mounts --no-quotes"
elif (command -v exa >/dev/null 2>&1); then
    alias ls="exa --time-style=long-iso --binary --group-directories-first --group --classify --color-scale --git"
fi
