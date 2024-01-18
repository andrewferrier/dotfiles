#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if uname | grep -iv linux > /dev/null; then
    OSDISTRIBUTION='macos'
else
    OSDISTRIBUTION=$(cat /etc/*-release | grep ^ID | sed -e 's/^.*=//')
fi

export OSDISTRIBUTION
