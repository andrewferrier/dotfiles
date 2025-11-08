#!/usr/bin/env bash

alias aria2c='aria2c --max-connection-per-server=5'
alias gzip='gzip --rsyncable'
alias ip='ip --color=auto'
alias lzip="lzip --best -m128 -s128MiB"
alias mkdir="mkdir -v"
alias rm='rm -Iv'
alias watch='watch --color'

RSYNC_OPTIONS='--human-readable --progress --partial --verbose --times --links'

# shellcheck disable=SC2139
alias rsync="rsync ${RSYNC_OPTIONS}"
# shellcheck disable=SC2139
alias rsync-progress-job="rsync ${RSYNC_OPTIONS} --info=progress2 --info=name0"

if (command -v uu-cp >/dev/null 2>&1); then
    # Rust coreutils are installed - Arch
    alias cp='uu-cp -v --sparse=always --reflink=auto --progress'
    alias mv='uu-mv -v --progress'
elif (command -v coreutils >/dev/null 2>&1); then
    # Rust coreutils are installed - Debian
    alias cp='coreutils cp -v --sparse=always --reflink=auto --progress'
    alias mv='coreutils mv -v --progress'
elif [[ ${OSTYPE} == darwin* ]]; then
    alias cp='cp -v'
    alias mv='mv -v'
else
    alias cp='cp -v --sparse=always --reflink=auto'
    alias mv='mv -v'
fi

if [[ ${OSTYPE} == darwin* ]]; then
    alias df='df -Ph'
    alias ps='pstree -g 3'
    alias sshfs='sshfs -o noapplexattr,noappledouble'
    alias sudo="sudo -p '[sudo] %p'\\''s password: '"
else
    alias df='df --print-type --human-readable'
    alias lsblk='lsblk --discard -o NAME,RM,RO,MOUNTPOINT,TYPE,FSTYPE,SIZE,FSUSED,UUID,LABEL,PARTLABEL,DISC-GRAN,DISC-MAX --paths'
    alias ps='COLUMNS=10000 ps -e -f --forest'
fi

# See also ~/.config/fd/ignore
FD_OPTIONS="--hidden --no-ignore-vcs"
if (command -v fdfind >/dev/null 2>&1); then
    # shellcheck disable=SC2139
    alias fd="fdfind ${FD_OPTIONS}"
else
    # shellcheck disable=SC2139
    alias fd="fd ${FD_OPTIONS}"
fi
