#!/usr/bin/env bash

LESS_TERMCAP_md="$(tput bold; tput setaf 4)"
LESS_TERMCAP_me="$(tput sgr0)"
LESS_TERMCAP_mb="$(tput blink)"
LESS_TERMCAP_us="$(tput setaf 2)"
LESS_TERMCAP_ue="$(tput sgr0)"
LESS_TERMCAP_so="$(tput smso)"
LESS_TERMCAP_se="$(tput rmso)"

export LESS_TERMCAP_md LESS_TERMCAP_me LESS_TERMCAP_mb LESS_TERMCAP_us LESS_TERMCAP_ue LESS_TERMCAP_so LESS_TERMCAP_se

export PAGER=less
