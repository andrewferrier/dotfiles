#!/usr/bin/env bash

function generate-password-human() {
    WORDS_LENGTH=${1:-4}
    shuf -n${WORDS_LENGTH} /usr/share/dict/words | tr -d "'\n\r" && echo ""
}

function generate-password-machine() {
    LENGTH=${1:-32}
    pwgen --secure --capitalize --numerals --symbols "${LENGTH}" 1
}

function generate-password-machine-typeable() {
    LENGTH=${1:-32}
    pwgen --secure --capitalize --numerals "${LENGTH}" 1
}
