ANTIDOTE_INSTALL=${ZSH_CACHE_FOLDER}/antidote
ZSH_PLUGINS=${ZDOTDIR:-~}/.zsh_plugins

if [[ ! -e $ANTIDOTE_INSTALL ]]; then
    git clone --depth=1 https://github.com/mattmc3/antidote.git $ANTIDOTE_INSTALL
fi

# Lazy-load antidote from its functions directory.
fpath=($ANTIDOTE_INSTALL/functions $fpath)
autoload -Uz antidote

if [[ ! ${ZSH_PLUGINS}.zsh -nt ${ZSH_PLUGINS}.txt ]]; then
    echo -n "Rebuilding plugin script... "
    antidote bundle <${ZSH_PLUGINS}.txt >|${ZSH_PLUGINS}.zsh
    echo "done."
fi
