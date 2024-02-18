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

ifeq ($(origin FULLINSTALL),undefined)
	INSTALL_TYPE := simple-install
else
	INSTALL_TYPE := full-install
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
	stow --verbose --dir=$(STOW) --target=$(HOME) --stow $(INSTALL_TYPE)
	stow-if-command $(STOW)/if-command

# CONFIGURE

configure: configure-fullinstall
	run-directory $(CONFIGURE)/all
	run-directory $(CONFIGURE)/if-os/$(OS)
	run-directory $(CONFIGURE)/if-osdistribution/$(OSDISTRIBUTION)
	run-directory $(CONFIGURE)/$(INSTALL_TYPE)
	run-if-command $(CONFIGURE)/if-command-after
