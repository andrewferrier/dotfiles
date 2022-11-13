# Adapted from https://www.archlinux.org/packages/extra/any/grml-zsh-config/
function mkdir-assistance-in-place-named () {
    local PATHTOMKDIR

    if ((REGION_ACTIVE==1)); then
        local F=$MARK T=$CURSOR

        if [[ $F -gt $T ]]; then
            F=${CURSOR}
            T=${MARK}
        fi

        PATHTOMKDIR=${BUFFER[F+1,T]%%[[:space:]]##}
        PATHTOMKDIR=${PATHTOMKDIR##[[:space:]]##}
    else
        local bufwords iword
        bufwords=(${(z)LBUFFER})
        iword=${#bufwords}
        bufwords=(${(z)BUFFER})
        PATHTOMKDIR="${(Q)bufwords[iword]}"
    fi

    [[ -z "${PATHTOMKDIR}" ]] && return 1

    PATHTOMKDIR=${~PATHTOMKDIR}

    if [[ -e "${PATHTOMKDIR}" ]]; then
        zle -M "Path ${PWD}/${PATHTOMKDIR} already exists, doing nothing."
    else
        mkdir -p "${PATHTOMKDIR}"
        zle -M "Path ${PWD}/${PATHTOMKDIR} made."
    fi
}

# Adapted from https://github.com/grml/grml-etc-core/blob/master/etc/zsh/zshrc
function mkdir-assistance-in-place-temp() {
    DIR=/tmp/$(date +%Y-%m-%dT%H:%M:%S)
    mkdir $DIR > /dev/null
    zle -U "$DIR "
}

zle -N mkdir-assistance-in-place-named
zle -N mkdir-assistance-in-place-temp

bindkey "^X." mkdir-assistance-in-place-named
bindkey "^X," mkdir-assistance-in-place-temp
