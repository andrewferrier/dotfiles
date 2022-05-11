if (( $+commands[fasd] )); then
    eval "$(fasd --init zsh-hook)"
fi

if (( $+commands[direnv] )); then
    eval "$(direnv hook zsh)"
fi
