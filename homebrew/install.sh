#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Check for Homebrew and install it if missing
if test ! $(which brew)
then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

apps=(
	ant
	antigen
	node
	jenv
	openssl
        wget
)

#
brew install "${apps[@]}"


### CREDITS @nicksp
