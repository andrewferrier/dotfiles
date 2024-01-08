if type fasd &>/dev/null; then
    fasd --init zsh-hook > $ZSH_CACHE_FOLDER/fasd-zsh-hook.zsh
    chmod +x $ZSH_CACHE_FOLDER/fasd-zsh-hook.zsh
else
    >&2 echo 'WARNING: fasd not installed.'
fi
