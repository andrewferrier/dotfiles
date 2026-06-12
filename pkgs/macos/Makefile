MKFILE_PATH := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

.PHONY: all brew_cleanup brew_file brew_install

all: brew_file

brew_file: brew_install brew_cleanup
	brew upgrade

	brew bundle --verbose --no-lock --file=$(MKFILE_PATH)/Brewfile

	# Upgrade all brew casks; provided by https://github.com/buo/homebrew-cask-upgrade
	brew cu --all --yes

brew_cleanup: brew_install
	# Run brew cleanup to make sure there are no broken symlinks etc. before
	# we install/upgrade anything
	brew cleanup

brew_install:
	if ! command -v brew &>/dev/null; then \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	fi
