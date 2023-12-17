#!/usr/bin/env bash

# shellcheck disable=2154
export HISTFILE="${XDG_STATE_HOME}/bash/history"

HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth
shopt -s histappend

shopt -s checkwinsize

[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

if [[ -x /usr/bin/tput ]] && tput setaf 1 >&/dev/null; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\u@\h:\w\$ '
fi

if ! shopt -oq posix; then
    if [[ -f /usr/share/bash-completion/bash_completion ]]; then
        # shellcheck source=/dev/null
        . /usr/share/bash-completion/bash_completion
    elif [[ -f /etc/bash_completion ]]; then
        # shellcheck source=/dev/null
        . /etc/bash_completion
    fi
fi

# shellcheck source=/dev/null
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
