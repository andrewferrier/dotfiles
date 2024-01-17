#!/usr/bin/env bash

if (command -v batcat >/dev/null 2>&1); then
    alias bat=batcat
    alias cat=batcat

    export MANPAGER="sh -c 'col -bx | batcat -l man -p --paging auto'"
    export MANROFFOPT="-c"
elif (command -v bat >/dev/null 2>&1); then
    alias cat=bat

    export MANPAGER="sh -c 'col -bx | bat -l man -p --paging auto'"
    export MANROFFOPT="-c"
fi
