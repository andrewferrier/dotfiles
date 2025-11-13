if [[ -f ~/memy/hooks/zsh ]]; then
    source ~/memy/hooks/zsh
else
    if command -v memy >/dev/null 2>/dev/null; then
        source <(memy hook zsh)
    fi
fi

if command -v memy >/dev/null 2>/dev/null; then
    source <(memy completions zsh)
fi
