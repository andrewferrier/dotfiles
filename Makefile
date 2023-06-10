.PHONY: pkgs stow

MKFILE_PATH := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PATH := $(MKFILE_PATH)/.bin:$(PATH)

CONFIGURE := $(MKFILE_PATH)/configure
STOW := $(MKFILE_PATH)/stow

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

stow:
	mkdir -p ${HOME}/.config ${HOME}/.local/share ${HOME}/.local/state
	stow --verbose --dir=$(STOW) --target=$(HOME) --stow common
	stow --verbose --dir=$(STOW) --target=$(HOME) --stow $(OS)
	stow --verbose --dir=$(STOW) --target=$(HOME) --stow $(OSDISTRIBUTION)
	stow-if-command $(STOW)/if-command

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
