# Job Control
setopt AUTO_CONTINUE
setopt CHECK_JOBS
setopt NO_HUP

# Completion
setopt NO_LIST_BEEP

# Directory changing
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHDMINUS
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# Input/output
if is-at-least 5.9; then
    setopt CLOBBER_EMPTY
fi

setopt NO_CLOBBER
unsetopt FLOW_CONTROL

# History configuration
HISTFILE="${XDG_DATA_HOME}/.zsh_history"
HISTSIZE=2000
SAVEHIST=2000

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY

unsetopt BEEP # This stops visual beeping (flash) when completing.
