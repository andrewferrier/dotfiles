#!/usr/bin/env bash

if (command -v batcat >/dev/null 2>&1); then
    alias bat=batcat
    alias cat=batcat
    alias less='bat --paging always'

    export MANPAGER="sh -c 'col --no-backspaces --spaces | batcat --style plain --language man --paging auto'"
    export MANROFFOPT="-c"
elif (command -v bat >/dev/null 2>&1); then
    alias cat=bat
    alias less='bat --paging always'

    export MANPAGER="sh -c 'col --no-backspaces --spaces | bat --style plain --language man --paging auto'"
    export MANROFFOPT="-c"
fi
