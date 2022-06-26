#!/usr/bin/env bash

alias id3v2='echo "Do not use id3v2: use eyeD3 instead, it'"'"'s more modern !"'
alias scp="echo 'Do not use scp: deprecated (https://lwn.net/SubscriberLink/835962/ae41b27bc20699ad/) !'"
alias xz="echo 'Do not use xz: https://www.nongnu.org/lzip/xz_inadequate.html !'"

if (! command -v tree >/dev/null 2>&1); then
    alias tree='echo "Use exa --tree instead!"'
fi
