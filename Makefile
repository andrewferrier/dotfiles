export DOTFILES := $(HOME)/dotfiles
export DOTFILES_COMMON := $(DOTFILES)/common

.PHONY: all if-command

all: if-command
	stow --verbose --dir=$(DOTFILES) --target=$(HOME) --stow common

if-command:
	bin/process-if-command
