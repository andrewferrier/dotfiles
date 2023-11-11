#!/usr/bin/env bash
#
# shellcheck disable=SC2086
# shellcheck disable=SC2139

if (command -v todo >/dev/null 2>&1); then
    readonly FILTER_BOX="cut -d' ' -f3-"
    readonly PREVIEW="--preview 'todo show {1}'"
    readonly OPTIONS="--ansi --tac --preview-window=top,5"

    readonly RELOAD="reload(todo --color always list | ${FILTER_BOX})"

    readonly TODAY="\$(date +%Y-%m-%d)"
    readonly TOMORROW="\$(date --date=tomorrow +%Y-%m-%d)"

    readonly RELOAD_KEY="--bind \"ctrl-r:${RELOAD}\""
    readonly DELETE_KEY="--bind \"ctrl-delete:execute(todo delete --yes {1})+${RELOAD}\""
    readonly ENTER_KEY="--bind \"enter:execute(todo done {1})+${RELOAD}\""
    readonly EDIT_KEY="--bind \"ctrl-e:execute(todo edit {1})+${RELOAD}\""
    readonly EDIT_RAW_KEY="--bind \"ctrl-a:execute(todo edit --raw {1})+${RELOAD}\""
    readonly EDIT_TODAY_KEY="--bind \"ctrl-y:execute(todo edit --due ${TODAY} {1})+${RELOAD}\""
    readonly EDIT_TOMORROW_KEY="--bind \"ctrl-w:execute(todo edit --due ${TOMORROW} {1})+${RELOAD}\""
    readonly NEW_KEY="--bind \"ctrl-n:execute(todo new --interactive)+${RELOAD}\""

    readonly KEYS_1="${RELOAD_KEY} ${DELETE_KEY} ${ENTER_KEY}"
    readonly KEYS_2="${EDIT_KEY} ${EDIT_RAW_KEY} ${EDIT_TODAY_KEY} ${EDIT_TOMORROW_KEY} ${NEW_KEY}"

    alias todo-fzf="todo --color always list | ${FILTER_BOX} | fzf ${PREVIEW} ${OPTIONS} ${KEYS_1} ${KEYS_2}"
fi
