#!/usr/bin/env bash

if (command -v brew >/dev/null 2>&1); then
    # shellcheck disable=SC2139
    alias brew-clean-casks="brew list --casks -1 | fzf -m --reverse | xargs -n1 brew uninstall"
    # shellcheck disable=SC2139
    alias brew-clean-packages="comm -23 <(brew leaves | sort) <(cat ${HOME}/gitco/config/common/pkgs-macos/Brewfile | grep ^brew | cut -d'\"' -f2 | sort) | tac | fzf --multi --preview 'brew info {}' | xargs brew uninstall"
    alias brew-clean-taps="brew tap | fzf -m | xargs brew untap"
fi
