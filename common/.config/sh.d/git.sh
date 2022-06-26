#!/usr/bin/env bash

function git-commit-submodule() {
    base=$(basename "$1")
    git commit -m "Update commit on ${base}" "$1"
}

# shellcheck disable=SC2142
alias git-prune-local="git fetch --prune; git branch -r | awk '{print \$1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print \$1}' | xargs git branch -d;"
alias gpc='while true; do git add -i -p; if ! git commit; then break; fi; done'
