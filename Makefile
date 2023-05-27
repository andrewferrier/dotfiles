.PHONY: if-os

MKFILE_PATH := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PATH := $(MKFILE_PATH)/.bin:$(PATH)

CONFIGURE := $(MKFILE_PATH)/configure
PKGS := $(MKFILE_PATH)/pkgs

DESKTOP := $(shell .bin/target-desktop)

ifeq ($(shell uname | grep -i linux),)
	OS := macos
	OSDISTRIBUTION := macos
else
	OS := linux
	OSDISTRIBUTION := $(shell cat /etc/*-release | grep ^ID | sed -e 's/^.*=//')
endif

# TOP-LEVEL

common: stow pkgs configure

# STOW

stow: stow-$(OS) $(DESKTOP) stow-if-command
	stow --verbose --dir=$(MKFILE_PATH) --target=$(HOME) --stow common

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

pkgs: pkgs-$(OSDISTRIBUTION)

pkgs-arch:

pkgs-debian:

pkgs-alpine:
	(cd $(PKGS)/alpine && make)

pkgs-macos:
	(cd $(PKGS)/macos && make)

# CONFIGURE

configure: configure-if-osdistribution configure-if-command

configure-if-osdistribution:
	run-directory $(CONFIGURE)/if-osdistribution/$(OSDISTRIBUTION)

configure-if-command:
	run-if-command $(CONFIGURE)/if-command-after
