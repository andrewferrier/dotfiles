# Ensure precmds are run after cd
function fzf-redraw-prompt() {
    local precmd
    for precmd in $precmd_functions; do
        $precmd
    done
    zle reset-prompt
}

function file-list-fzf-get-dir() {
    setopt localoptions pipefail no_aliases 2> /dev/null
    local dir="$(file-list -d -s)"
    dir=${dir:s/~/$HOME}
    echo $dir
}

function file-list-fzf-switch-or-insert-dir() {
    dir=$(file-list-fzf-get-dir)

    # Check if only whitespace in line inserted so far.
    if [[ -z "${BUFFER// }" ]]; then
        if [[ -z "$dir" ]]; then
            zle redisplay
            return 0
        else
            cd "$dir"
            unset dir # ensure this doesn't end up appearing in prompt expansion
            local ret=$?
            fzf-redraw-prompt
            return $ret
        fi
    else
        zle -U "${(q)dir} "
        local ret=$?
        zle reset-prompt
        return $ret
    fi
}

zle     -N   file-list-fzf-switch-or-insert-dir
bindkey '^G' file-list-fzf-switch-or-insert-dir

function file-list-fzf-insert-file-select() {
    setopt localoptions pipefail no_aliases 2> /dev/null
    local files="$(file-list -f -s -m)"
    if [ ! -z $files ]; then
        echo "$files" | while read item; do
        item=${item:s/~/$HOME}
        echo -n "${(q)item} "
    done
    fi
    local ret=$?
    echo
    return $ret
}

function file-list-fzf-insert-file() {
    zle -U "$(file-list-fzf-insert-file-select)"
    local ret=$?
    zle reset-prompt
    return $ret
}

zle     -N   file-list-fzf-insert-file
bindkey '^F' file-list-fzf-insert-file
