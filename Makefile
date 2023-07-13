.PHONY: pkgs stow pre-stow

MKFILE_PATH := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PATH := $(MKFILE_PATH)/.bin:$(PATH)

CONFIGURE := $(MKFILE_PATH)/configure
STOW := $(MKFILE_PATH)/stow
PRE_STOW := $(MKFILE_PATH)/pre-stow

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

pre-stow:
	run-directory $(PRE_STOW)/common
	run-directory $(PRE_STOW)/$(OS)

stow: pre-stow
	stow --verbose --dir=$(STOW) --target=$(HOME) --stow common
	stow --verbose --dir=$(STOW) --target=$(HOME) --stow $(OS)
	stow --verbose --dir=$(STOW) --target=$(HOME) --stow $(OSDISTRIBUTION)
	stow-if-command $(STOW)/if-command

# CONFIGURE

configure: configure-fullinstall
	run-directory $(CONFIGURE)/all
	run-directory $(CONFIGURE)/if-os/$(OS)
	run-directory $(CONFIGURE)/if-osdistribution/$(OSDISTRIBUTION)
	run-if-command $(CONFIGURE)/if-command-after

ifeq ($(origin FULLINSTALL),undefined)

configure-fullinstall:

else

configure-fullinstall:
	run-directory $(CONFIGURE)/full-install

endif
