export DOTFILES_COMMON := $(HOME)/dotfiles

all:
	stow --verbose --dir=$(DOTFILES_COMMON)/common --target=$(HOME) --stow home-ferriera
