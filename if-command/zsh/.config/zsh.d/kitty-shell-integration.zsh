# See https://sw.kovidgoyal.net/kitty/shell-integration/#shell-integration
#
# Although it's definitely not required to do this manually, I prefer to retain
# control over it.
if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="enabled"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi
