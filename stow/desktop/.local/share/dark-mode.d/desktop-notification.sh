#!/usr/bin/env bash

MODE_NAME=${1:-dark}
"${HOME}/.local/bin/common-dotfiles/notify" --severity 3 "switching to ${MODE_NAME} mode"
