#!/usr/bin/env bash

if (command -v batcat >/dev/null 2>&1); then
    alias bat=batcat
    alias cat=batcat
elif (command -v bat >/dev/null 2>&1); then
    alias cat=bat
fi
