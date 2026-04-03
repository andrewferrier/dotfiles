#!/usr/bin/env bash

alias lpr-onesided='lpr -o sides=one-sided'
alias lpr-twosided='lpr -o sides=two-sided-long-edge'
alias reenable-printer='lpq | head -1 | cut -d" " -f1 | xargs lpadmin -E -p'

function lpr-image-fitpage() {
    local IMAGE_FILE="${1:?Must pass in an image filename}"
    if [[ ! -f "$IMAGE_FILE" ]]; then
        echo "Error: File not found: $IMAGE_FILE"
        return 1
    fi

    local DIMENSIONS
    if ! DIMENSIONS=$(identify -format "%wx%h" "$IMAGE_FILE" 2>/dev/null) || [[ -z "$DIMENSIONS" ]]; then
        echo "Error: Could not get dimensions for $IMAGE_FILE. Is it a valid image?"
        return 1
    fi

    local WIDTH HEIGHT
    WIDTH=$(echo "$DIMENSIONS" | cut -d'x' -f1)
    HEIGHT=$(echo "$DIMENSIONS" | cut -d'x' -f2)

    local ORIENTATION="portrait"
    if (( WIDTH * 210 > HEIGHT * 297 )); then # A4 landscape aspect ratio: 297/210
        ORIENTATION="landscape"
    fi

    echo "Printing '$IMAGE_FILE' in $ORIENTATION mode, fitting to page..."
    lpr -o orientation-requested="$ORIENTATION" -o fit-to-page "$IMAGE_FILE"
}
