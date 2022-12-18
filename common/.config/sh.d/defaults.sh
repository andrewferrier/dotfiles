#!/usr/bin/env bash

alias gzip='gzip --rsyncable'
alias ip='ip --color=auto'
alias lzip="lzip --best -m128 -s128MiB"
alias mkdir="mkdir -v"
alias mv="mv -v"
alias rsync='rsync --human-readable --progress --partial --verbose --times --links'
alias watch='watch --color'

# See also ~/.config/fd/ignore
FD_OPTIONS="--hidden --no-ignore-vcs"
if (command -v fdfind >/dev/null 2>&1); then
    # shellcheck disable=SC2139
    alias fd="fdfind ${FD_OPTIONS}"
else
    # shellcheck disable=SC2139
    alias fd="fd ${FD_OPTIONS}"
fi
