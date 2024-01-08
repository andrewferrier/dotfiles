typeset -U fpath

fpath+=(/usr/local/share/zsh/functions)
fpath+=(/usr/local/share/zsh/site-functions)
fpath+=(/usr/share/zsh/site-functions)
fpath+=(/usr/share/zsh/vendor-completions)

if type brew &>/dev/null; then
    fpath+=($(brew --prefix)/share/zsh/site-functions)
fi
