#!/usr/bin/env bash

if (command -v btop >/dev/null 2>&1); then
    alias top="btop"
fi
