#!/usr/bin/env bash

if (command -v bat >/dev/null 2>&1); then
    alias cat="bat"
fi
