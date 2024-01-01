#!/usr/bin/env bash

export HIGHLIGHT_OPTIONS="--style=base16/gruvbox-light-hard"
export RIPGREP_CONFIG_PATH=${XDG_CONFIG_HOME}/ripgrep/rc.conf
export FZF_DEFAULT_OPTS_INITIAL='--exact'

# This sets a default for when ~/.local/bin/common/day-night-terminal-setup is
# not used for some reason
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS_INITIAL
