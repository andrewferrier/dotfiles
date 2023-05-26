.PHONY: if-os

MKFILE_PATH := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PATH := $(MKFILE_PATH)/.bin:$(PATH)

DESKTOP := $(shell .bin/target-desktop)

ifeq ($(shell uname | grep -i linux),)
	OS := macos
else
	OS := linux
endif

# TOP-LEVEL

common: stow pkgs configure

pkgs: pkgs-$(OS)

stow: stow-$(OS) $(DESKTOP) stow-if-command
	stow --verbose --dir=$(MKFILE_PATH) --target=$(HOME) --stow common

configure: configure-if-os configure-if-command

# STOW

stow-macos:
	stow --verbose --dir=$(MKFILE_PATH) --target=$(HOME) --stow macos

stow-linux:
	stow --verbose --dir=$(MKFILE_PATH) --target=$(HOME) --stow linux

stow-desktop: stow-$(OS)-desktop
	stow --verbose --dir=$(MKFILE_PATH) --target=$(HOME) --stow desktop

stow-linux-desktop:
	stow --verbose --dir=$(MKFILE_PATH) --target=$(HOME) --stow linux-desktop

stow-macos-desktop:

stow-if-command:
	stow-if-command $(MKFILE_PATH)/if-command

# PKGS

pkgs-linux:

pkgs-macos:
	(cd pkgs/macos && make)

# CONFIGURE

configure-if-os:
	run-directory $(MKFILE_PATH)/if-os/$(OS)

configure-if-command:
	run-if-command $(MKFILE_PATH)/if-command-after
