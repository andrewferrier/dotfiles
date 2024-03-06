#!/usr/bin/env bash

if (command -v brew >/dev/null 2>&1); then
    alias brew-clean-casks="brew list --casks -1 | fzf -m --reverse --preview 'brew info {}' | xargs -n1 brew uninstall"
    # shellcheck disable=SC2139
    alias brew-clean-packages="comm -23 <(brew leaves | sort) <(cat ${HOME}/dotfiles/pkgs/macos/Brewfile | grep ^brew | cut -d'\"' -f2 | sort) | tac | fzf --multi --preview 'brew info {}' | xargs brew uninstall"
    alias brew-clean-taps="brew tap | fzf -m | xargs brew untap"
    alias brew-view-installed="(brew list --formula -1 && brew list --casks -1) | sort | fzf --preview 'brew info {}' --reverse"
fi
