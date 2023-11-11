#!/usr/bin/env bash

if (command -v todo >/dev/null 2>&1); then
    readonly RELOAD="reload(todo --color always list | cut -d' ' -f3-)"

    readonly TODAY="\$(date +%Y-%m-%d)"
    readonly TOMORROW="\$(date --date=tomorrow +%Y-%m-%d)"

    function todo-fzf {
        # shellcheck disable=SC2312
        todo --color always list |
            cut -d' ' -f3- |
            fzf --preview 'todo show {1}' \
                --ansi \
                --tac \
                --preview-window=top,5 \
                --bind "ctrl-r:${RELOAD}" \
                --bind "ctrl-delete:execute(todo delete --yes {1})+${RELOAD}" \
                --bind "enter:execute(todo done {1})+${RELOAD}" \
                --bind "ctrl-e:execute(todo edit {1})+${RELOAD}" \
                --bind "ctrl-a:execute(todo edit --raw {1})+${RELOAD}" \
                --bind "ctrl-y:execute(todo edit --due ${TODAY} {1})+${RELOAD}" \
                --bind "ctrl-w:execute(todo edit --due ${TOMORROW} {1})+${RELOAD}" \
                --bind "ctrl-n:execute(todo new --interactive)+${RELOAD}"
    }
fi
