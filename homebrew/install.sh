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
	pkg-config
	pnpm@8
	ripgrep
	svgo
	tldr
	tree
	wget
	yq
	zsh-completions
	zsh-syntax-highlighting
	zsh-autosuggestions
)
brew install "${dependecies[@]}"
