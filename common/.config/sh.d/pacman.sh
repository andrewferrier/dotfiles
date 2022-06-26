#!/usr/bin/env bash

if (command -v pacman >/dev/null 2>&1); then
    alias pacman-clean-packages="sudo pacman -Rns \$(pacman -Qtdq) ; sudo pacman -R \$(pacman -Qt | cut -d' ' -f1 | fzf --multi --preview 'pacman -Qil {}' --layout=reverse)"
    alias pacman-install-packages="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' --layout=reverse | xargs -ro sudo pacman -S"
    alias pacman-mark-explicit="comm <(pacman -Qe | cut -d' ' -f1 | sort) <(pacman -Q | cut -d' ' -f1 | sort) -13 | fzf -m --layout=reverse --preview 'pacman -Qil {}' | xargs sudo pacman -D --asexplicit"
    alias pacman-mark-implicit="pacman -Qe | cut -f1 -d' ' | fzf -m --layout=reverse --preview 'pacman -Qil {}' | xargs sudo pacman -D --asdeps"
    alias pacman-view-all-packages="pacman -Ss | sed '2~2d' | cut -f1 -d' ' | fzf --preview 'pacman -Si {}' --layout=reverse"
    alias pacman-view-installed-packages="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"

    alias pacaur='pacaur --noedit'
fi
