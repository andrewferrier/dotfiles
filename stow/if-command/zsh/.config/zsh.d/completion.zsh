# See https://thevaluable.dev/zsh-completion-guide-examples/, https://carlosbecker.com/posts/speeding-up-zsh/

COMPLETION_CACHE_DIR="${XDG_CACHE_HOME}/zsh/completion"
ZCOMPDUMP="${COMPLETION_CACHE_DIR}/.zcompdump"

mkdir -p ${COMPLETION_CACHE_DIR}

autoload -U compinit
compinit -d ${ZCOMPDUMP}

zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

zstyle ':completion:*' list-prompt ''
zstyle ':completion:*' select-prompt ''

zstyle ':completion:*' group-name ''
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' special-dirs true

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

zstyle ':completion:*:*:*:*:*' menu select

zstyle ':completion:*:*:*:*' completer _extensions _complete _approximate

zstyle ':completion:*:*:*:*' use-cache on
zstyle ':completion:*:*:*:*' cache-path ${COMPLETION_CACHE_DIR}

# disable named-directories autocompletion
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories

# Don't use (potentially huge) /etc/hosts for completion of ssh, etc. -
# https://superuser.com/a/1412039.
zstyle -e ':completion:*:hosts' hosts 'reply=(
    ${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) 2>/dev/null)"}%%[#| ]*}//,/ }
    ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2>/dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
    )'

setopt ALWAYS_TO_END
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt LIST_PACKED
setopt NO_CORRECT_ALL
setopt NO_MENU_COMPLETE

# automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit

if [[ -s "$ZCOMPDUMP" && (! -s "${ZCOMPDUMP}.zwc" || "$ZCOMPDUMP" -nt "${ZCOMPDUMP}.zwc") ]]; then
    zcompile "$ZCOMPDUMP"
fi
