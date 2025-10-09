#!/bin/bash

# Check for Homebrew and install it if missing
if test ! $(which brew)
then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

dependecies=(
	ack
	ant
	autojump
	bat
	cairo
	diff-so-fancy
	eza
	fd
	fzf
	git
	gnupg
	gsed
	httpie
	imagemagick
	jq
	links
	mas
	nmap
	nvm
	openssl
	pango
	python@3.11
	pkg-config
	pnpm@8
	ripgrep
	# svgo disabled due to issues with node version
	tldr
	tree
	wget
	yq
	zsh-completions
	zsh-syntax-highlighting
	zsh-autosuggestions
)
brew install "${dependecies[@]}"
