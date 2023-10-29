#!/usr/bin/env bash

if (command -v todo >/dev/null 2>&1); then
    alias todo-delete="todo --color always list | fzf --ansi --tac --multi | cut -d' ' -f3 | xargs todo delete --yes"
    alias todo-done="todo --color always list | fzf --ansi --tac --multi | cut -d' ' -f3 | xargs todo done"
    alias todo-new-today="todo new --due today"
    alias todo-new-tomorrow="todo new --due tomorrow"
fi
