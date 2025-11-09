#!/usr/bin/env bash

if (command -v fdupes >/dev/null 2>&1); then
    alias fdupes='fdupes --cache'
fi
