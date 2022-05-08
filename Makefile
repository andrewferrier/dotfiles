export DOTFILES := $(HOME)/dotfiles
export DOTFILES_COMMON := $(DOTFILES)/common

.PHONY: all macos linux common-desktop linux-desktop if-command

DESKTOP := $(shell .bin/target-desktop)

ifeq ($(shell uname | grep -i linux),)
	OS := macos
	export OSDISTRIBUTION := macos
else
	OS := linux
	export OSDISTRIBUTION := $(shell lsb_release --short --id | tr A-Z a-z)
endif

all: if-command $(if $(DESKTOP), common-desktop) $(OS)
	stow --verbose --dir=$(DOTFILES) --target=$(HOME) --stow common

macos:
	stow --verbose --dir=$(DOTFILES) --target=$(HOME) --stow macos

linux:

common-desktop: $(OS)-desktop
	stow --verbose --dir=$(DOTFILES) --target=$(HOME) --stow common-desktop

linux-desktop:
	stow --verbose --dir=$(DOTFILES) --target=$(HOME) --stow linux-desktop

if-command:
	.bin/process-if-command
