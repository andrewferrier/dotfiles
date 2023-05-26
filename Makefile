MKFILE_PATH := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PATH := $(MKFILE_PATH)/.bin:$(PATH)

DESKTOP := $(shell .bin/target-desktop)

ifeq ($(shell uname | grep -i linux),)
	OS := macos
else
	OS := linux
endif

# ******* EXTERNAL TARGETS

common: pkgs cfg if-command
	stow --verbose --dir=$(MKFILE_PATH) --target=$(HOME) --stow common

pkgs: pkgs-$(OS)

cfg: $(DESKTOP) cfg-$(OS)

# *******

macos: pkgs-macos cfg-macos

pkgs-macos:
	(cd pkgs/macos && make)

cfg-macos:
	stow --verbose --dir=$(MKFILE_PATH) --target=$(HOME) --stow macos
	cfg-macos

linux: cfg-$(OS)

pkgs-linux:

cfg-linux:
	stow --verbose --dir=$(MKFILE_PATH) --target=$(HOME) --stow linux

desktop: $(OS)-desktop
	stow --verbose --dir=$(MKFILE_PATH) --target=$(HOME) --stow desktop

linux-desktop:
	stow --verbose --dir=$(MKFILE_PATH) --target=$(HOME) --stow linux-desktop

macos-desktop:

if-command:
	.bin/process-if-command
