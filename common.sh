#!/usr/bin/env bash

# shellcheck disable=SC2312
if uname | grep -iv linux > /dev/null; then
    OSDISTRIBUTION='macos'
else
    OSDISTRIBUTION=$(cat /etc/*-release | grep ^ID | sed -e 's/^.*=//')
fi

export OSDISTRIBUTION
