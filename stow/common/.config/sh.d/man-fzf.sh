#!/usr/bin/env bash

function man-fzf {
    # shellcheck disable=SC2016
    PREVIEW_CMD="echo {} | perl -pe 's/([\\S-]*)\\s*\\((\\S*)\\).*/\\2 \\1/g' | xargs man --"

    (
        set -o pipefail

        apropos . 2>/dev/null |
            sort --ignore-case |
            fzf --exact --tiebreak begin --preview "${PREVIEW_CMD}" |
            perl -pe 's/([\S-]*)\s*\((\S*)\).*/\2 \1/g' |
            xargs man --
    )
}
