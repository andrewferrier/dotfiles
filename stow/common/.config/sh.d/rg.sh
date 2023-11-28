#!/usr/bin/env bash

if (command -v rg >/dev/null 2>&1); then
    # shellcheck disable=SC2312
    RG_MAJOR_VERSION=$(rg --version | head -1 | cut -d' ' -f2 | cut -d'.' -f1)

    if ((RG_MAJOR_VERSION >= 14)); then
        alias rg='rg --hyperlink-format=default'
    fi
fi
