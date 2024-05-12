#!/usr/bin/env bash

if (command -v eza >/dev/null 2>&1); then
    export EZA_MIN_LUMINANCE=60
    alias ls="eza --time-style=long-iso --binary --group-directories-first --group --classify --color-scale --git --hyperlink --mounts --no-quotes --icons=auto"
fi
