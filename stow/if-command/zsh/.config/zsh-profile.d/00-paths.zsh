if [[ "$OSTYPE" == "linux-gnu" ]]; then
    readonly ZSH_CACHE_FOLDER=${XDG_CACHE_HOME}/zsh
else
    readonly ZSH_CACHE_FOLDER=${HOME}/Library/Caches/zsh
fi

export ZSH_CACHE_FOLDER
mkdir -p $ZSH_CACHE_FOLDER
