#!/usr/bin/env bash

set -o nounset
set -o pipefail

verlte() {
    if (command -v gsort >/dev/null 2>&1); then
        SORT_CMD="gsort"
    else
        SORT_CMD="sort"
    fi

    printf '%s\n' "$1" "$2" | $SORT_CMD --check=quiet --version-sort
}

if (command -v ncdu >/dev/null 2>&1); then
    NCDU_VERSION=$(ncdu --version | cut -d' ' -f2)

    if verlte 2.5 "$NCDU_VERSION"; then
        CORES=$(python3 -c 'import multiprocessing as mp; print(mp.cpu_count())')
        # shellcheck disable=SC2139
        alias ncdu="ncdu --threads ${CORES}"
    fi
fi
