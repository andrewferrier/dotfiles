ANTIDOTE_INSTALL=${ZSH_CACHE_FOLDER}/antidote

# Lazy-load antidote from its functions directory.
fpath=($ANTIDOTE_INSTALL/functions $fpath)
autoload -Uz antidote

ZSH_PLUGINS=${ZDOTDIR:-~}/.zsh_plugins
source ${ZSH_PLUGINS}.zsh
