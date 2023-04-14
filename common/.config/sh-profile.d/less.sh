#!/usr/bin/env bash

BOLD=$(tput bold)
RESET=$(tput sgr0)
BLINK=$(tput blink)
GREEN=$(tput setaf 2)
REVERSE=$(tput smso)
NORMAL=$(tput rmso)

export LESS_TERMCAP_md="$BOLD$GREEN"
export LESS_TERMCAP_me="$RESET"
export LESS_TERMCAP_mb="$BOLD$BLINK"
export LESS_TERMCAP_us="$GREEN"
export LESS_TERMCAP_ue="$RESET"
export LESS_TERMCAP_so="$REVERSE"
export LESS_TERMCAP_se="$NORMAL"

export PAGER=less
