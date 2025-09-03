if [[ -f ~/memy/hooks/zsh ]]; then
    source ~/memy/hooks/zsh
else
    source <(memy hook zsh)
fi

source <(memy completions zsh)
