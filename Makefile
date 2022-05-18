export DOTFILES := $(HOME)/dotfiles
export DOTFILES_COMMON := $(DOTFILES)/common

.PHONY: common macos linux desktop linux-desktop if-command

DESKTOP := $(shell .bin/target-desktop)

ifeq ($(shell uname | grep -i linux),)
	OS := macos
else
	OS := linux
endif

common: if-command $(DESKTOP) $(OS)
	stow --verbose --dir=$(DOTFILES) --target=$(HOME) --stow common

macos:
	stow --verbose --dir=$(DOTFILES) --target=$(HOME) --stow macos

linux:
	stow --verbose --dir=$(DOTFILES) --target=$(HOME) --stow linux

desktop: $(OS)-desktop
	stow --verbose --dir=$(DOTFILES) --target=$(HOME) --stow desktop

linux-desktop:
	stow --verbose --dir=$(DOTFILES) --target=$(HOME) --stow linux-desktop

macos-desktop:

if-command:
	.bin/process-if-command
