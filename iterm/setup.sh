#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew install starship

brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font

cp zshrc ~/.zshrc
