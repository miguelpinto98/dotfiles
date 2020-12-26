#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Check for Homebrew and install it if missing
if test ! $(which brew)
then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

dependecies=(
	ack
	ant
	antigen
	autojump
	bash-completion
	diff-so-fancy
	git
	jenv
	links
	ngrok
	nmap
	nvm
	openssl
	rbenv
	tree
	wget
	zsh
	zsh-completions
)
brew install "${dependecies[@]}"
