#!/usr/bin/env bash

if [[ -f ~/memy/hooks/bash ]]; then
    # shellcheck source=/dev/null
    source ~/memy/hooks/bash
else
    # shellcheck source=/dev/null
    # shellcheck disable=2312
    source <(memy hook bash)
fi
