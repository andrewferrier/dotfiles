#!/usr/bin/env bash

export PAGER=less
export RIPGREP_CONFIG_PATH=${XDG_CONFIG_HOME:-${HOME}/.config}/ripgrep/rc.conf

export FZF_DEFAULT_OPTS_INITIAL='--exact'

if command -v fzf >/dev/null 2>/dev/null; then
    # shellcheck disable=SC2312
    FZF_VERSION=$(fzf --version | cut -d'.' -f2)
    if ((FZF_VERSION >= 42)); then
        export FZF_DEFAULT_OPTS_INITIAL="$FZF_DEFAULT_OPTS_INITIAL --info=inline-right --no-separator"
    fi
fi

export FZF_DEFAULT_OPTS_LIGHT_COLORS="$FZF_DEFAULT_OPTS_INITIAL --color fg:#1d2021,bg:#f9f5d7,hl:#fb4934,fg+:#3c3836,bg+:#ebdbb2,hl+:#fb4934 --color info:#b8bb26,prompt:#b8bb26,spinner:#83a598,pointer:#fabd2f,marker:#665c54,header:#fe8019"
export FZF_DEFAULT_OPTS_DARK_COLORS="$FZF_DEFAULT_OPTS_INITIAL --color fg:#f9f5d7,bg:#1d2021,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54"

# This sets a default for when ~/.local/bin/common/day-night-terminal-setup is
# not used for some reason
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS_INITIAL
