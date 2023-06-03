readonly ANTIDOTE_PLUGIN_LIST=${HOME}/.config/zsh-profile.d/plugins.cfg
readonly ANTIDOTE_PLUGIN_SCRIPT=${ZSH_CACHE_FOLDER}/plugins.sh
readonly ANTIDOTE_CLONE_HOME=${ZSH_CACHE_FOLDER}/antidote

if [[ ! $ANTIDOTE_PLUGIN_SCRIPT -nt $ANTIDOTE_PLUGIN_LIST ]]; then
    echo -n "Rebuilding plugin script... "
    if [[ ! -e $ANTIDOTE_CLONE_HOME ]]; then
        git clone --depth=1 https://github.com/mattmc3/antidote.git $ANTIDOTE_CLONE_HOME
    fi

    (
        source $ANTIDOTE_CLONE_HOME/antidote.zsh
        antidote bundle <$ANTIDOTE_PLUGIN_LIST >$ANTIDOTE_PLUGIN_SCRIPT
    )
    echo "done."
fi
