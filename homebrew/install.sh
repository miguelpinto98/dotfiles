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
	bash-completion
	bat
	cask
	docker
	diff-so-fancy
	git
	imagemagick
	links
	mas
	nmap
	nvm
	openssl
	tldr
	tree
	the-unarchiver
	wget
	zsh
	zsh-completions
	zsh-syntax-highlighting
	zsh-autosuggestions
)
brew install "${dependecies[@]}"
