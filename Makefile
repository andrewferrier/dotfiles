export DOTFILES_COMMON := $(HOME)/dotfiles

all:
	stow --verbose --dir=$(DOTFILES_COMMON) --target=/ --stow common
