#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Check for Homebrew and install it if missing
if test ! $(which brew)
then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew cask
brew cask install java

dependecies=(
	ant
	antigen
	autojump
	bash-completion
	diff-so-fancy
	git
	jenv
	links
	nmap
	openssl
	rbenv
	tree
	wifi-password
  wget
	zsh
)
brew install "${dependecies[@]}"

plugins=(
	qlcolorcode
	qlstephen
	qlmarkdown
	quicklook-json
	betterzip
	qlimagesize
	suspicious-package
	qlvideo
	provisionql
)
brew cask install "${plugins[@]}"
