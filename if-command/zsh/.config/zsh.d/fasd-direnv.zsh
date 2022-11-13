if (( $+commands[fasd] )); then
    eval "$(cat $ZSH_CACHE_FOLDER/fasd-zsh-hook.zsh)"
fi

if (( $+commands[direnv] )); then
    eval "$(direnv hook zsh)"
fi
