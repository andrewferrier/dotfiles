#!/usr/bin/env bash

if (command -v glances &>/dev/null); then
    alias top=glances
fi
