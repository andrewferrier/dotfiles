# Based on https://github.com/michaelxmcbride/zsh-dircycle/blob/master/dircycle.zsh

function _dircycle-redraw-prompt() {
    local precmd
    for precmd in $precmd_functions; do
        $precmd
    done
    zle reset-prompt
}

_dircycle_update_cycled() {
    setopt localoptions nopushdminus

    [[ ${#dirstack} -eq 0 ]] && return

    while ! builtin pushd -q $1 &>/dev/null; do
        # A missing directory was found; pop it out of the directory stack.
        builtin popd -q $1

        # Stop trying if there are no more directories in the directory stack.
        [[ ${#dirstack} -eq 0 ]] && break
    done

    _dircycle-redraw-prompt
}

_dircycle_prev() {
    _dircycle_update_cycled +1 || true
}

_dircycle_next() {
    _dircycle_update_cycled -0 || true
}

_dircycle_up () {
    cd ..
    _dircycle-redraw-prompt
}

zle -N _dircycle_prev
zle -N _dircycle_next
zle -N _dircycle_up

# Key bindings - use 'cat -v' to discover them (and bindkey to view and remove
# potential conflicts)

bindkey '^[[1;3D' _dircycle_prev  # Alt-Left
bindkey '^[[1;3C' _dircycle_next # Alt-Right
bindkey '^[[1;3A' _dircycle_up # Alt+Up
