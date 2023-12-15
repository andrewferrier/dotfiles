#!/usr/bin/env bash

function generate-password-human() {
    CONFORM_TO_TYPICAL_RULES=$(pwgen --capitalize --numerals --symbols 3)

    WORDS_LENGTH=${1:-3}
    shuf -n"${WORDS_LENGTH}" /usr/share/dict/words | tr -d "'\n\r" && echo "$CONFORM_TO_TYPICAL_RULES"
}

function generate-password-machine() {
    LENGTH=${1:-32}
    pwgen --secure --capitalize --numerals --symbols "${LENGTH}" 1
}

function generate-password-machine-typeable() {
    LENGTH=${1:-32}
    pwgen --secure --capitalize --numerals "${LENGTH}" 1
}
