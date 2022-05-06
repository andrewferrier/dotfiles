export DOTFILES := $(HOME)/dotfiles
export DOTFILES_COMMON := $(DOTFILES)/common

.PHONY: all if-command

all: if-command
	stow --verbose --dir=$(DOTFILES_COMMON) --target=$(HOME) --stow home-ferriera

if-command:
	bin/process-if-command
