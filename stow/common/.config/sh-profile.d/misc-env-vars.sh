#!/usr/bin/env bash

export PAGER=less
export RIPGREP_CONFIG_PATH=${XDG_CONFIG_HOME:-${HOME}/.config}/ripgrep/rc.conf

# shellcheck disable=SC2312
FZF_VERSION=$(fzf --version | cut -d'.' -f2)

export FZF_DEFAULT_OPTS_INITIAL='--exact'
if ((FZF_VERSION >= 42)); then
    export FZF_DEFAULT_OPTS_INITIAL="$FZF_DEFAULT_OPTS_INITIAL --info=inline-right --no-separator"
fi

# This sets a default for when ~/.local/bin/common/day-night-terminal-setup is
# not used for some reason
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS_INITIAL
