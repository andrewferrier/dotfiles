export DOTFILES := $(HOME)/dotfiles
export DOTFILES_COMMON := $(DOTFILES)/common

.PHONY: all all-desktop linux-desktop if-command

DESKTOP := $(shell .bin/target-desktop)

ifeq ($(shell uname | grep -i linux),)
	OS := macos
	export OSDISTRIBUTION := macos
else
	OS := linux
	export OSDISTRIBUTION := $(shell lsb_release --short --id | tr A-Z a-z)
endif

all: if-command $(if $(DESKTOP), all-desktop)
	stow --verbose --dir=$(DOTFILES) --target=$(HOME) --stow common

all-desktop: $(OS)-desktop

linux-desktop:
	stow --verbose --dir=$(DOTFILES) --target=$(HOME) --stow linux-desktop

if-command:
	.bin/process-if-command
