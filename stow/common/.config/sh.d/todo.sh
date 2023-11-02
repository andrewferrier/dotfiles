#!/usr/bin/env bash
#
# shellcheck disable=SC2086
# shellcheck disable=SC2089
# shellcheck disable=SC2090
# shellcheck disable=SC2139
# shellcheck disable=SC2312

if (command -v todo >/dev/null 2>&1); then
    readonly FILTER_BOX="cut -d' ' -f3-"
    readonly PREVIEW="--preview 'todo show {1}'"
    readonly OPTIONS="--ansi --tac --preview-window=top,8"

    alias todo-delete="todo --color always list | ${FILTER_BOX} | fzf ${PREVIEW} ${OPTIONS} --multi | cut -d' ' -f1 | xargs todo delete --yes"
    alias todo-done="todo --color always list | ${FILTER_BOX} | fzf ${PREVIEW} ${OPTIONS} --multi | cut -d' ' -f1 | xargs todo done"

    alias todo-edit="todo edit \$(todo --color always list | ${FILTER_BOX} | fzf ${PREVIEW} ${OPTIONS} | cut -d' ' -f1)"
    alias todo-edit-raw="todo edit --raw \$(todo --color always list | ${FILTER_BOX} | fzf ${PREVIEW} ${OPTIONS} | cut -d' ' -f1)"

    alias todo-new-today="todo new --due today"
    alias todo-new-tomorrow="todo new --due tomorrow"
fi
