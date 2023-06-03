.PHONY: pkgs

MKFILE_PATH := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PATH := $(MKFILE_PATH)/.bin:$(PATH)

CONFIGURE := $(MKFILE_PATH)/configure

DESKTOP_OR_SERVER := $(shell .bin/target-desktop-or-server)

ifeq ($(shell uname | grep -i linux),)
	OS := macos
	OSDISTRIBUTION := macos
else
	OS := linux
	OSDISTRIBUTION := $(shell cat /etc/*-release | grep ^ID | sed -e 's/^.*=//')
endif

# TOP-LEVEL

all: pkgs quick

quick: stow configure

# PKGS

pkgs:
	(cd $(MKFILE_PATH)/pkgs/$(OSDISTRIBUTION) && $(MAKE))

# STOW

stow: stow-$(DESKTOP_OR_SERVER) stow-if-command
	stow --verbose --dir=$(MKFILE_PATH) --target=$(HOME) --stow common
	stow --verbose --dir=$(MKFILE_PATH) --target=$(HOME) --stow $(OS)

stow-server:
	stow --verbose --dir=$(MKFILE_PATH) --target=$(HOME) --stow server

stow-desktop: stow-$(OS)-desktop
	stow --verbose --dir=$(MKFILE_PATH) --target=$(HOME) --stow desktop

stow-linux-desktop:
	stow --verbose --dir=$(MKFILE_PATH) --target=$(HOME) --stow linux-desktop

stow-macos-desktop:

stow-if-command:
	stow-if-command $(MKFILE_PATH)/if-command

# CONFIGURE

configure: configure-all configure-if-osdistribution configure-if-command configure-fullinstall

configure-all:
	run-directory $(CONFIGURE)/all

configure-if-osdistribution:
	run-directory $(CONFIGURE)/if-osdistribution/$(OSDISTRIBUTION)

configure-if-command:
	run-if-command $(CONFIGURE)/if-command-after

ifeq ($(origin FULLINSTALL),undefined)

configure-fullinstall:

else

configure-fullinstall:
	run-directory $(CONFIGURE)/full-install

endif
