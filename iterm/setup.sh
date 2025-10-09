#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# close omz
exit

brew install starship

brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font

source ~/.zshrc

git clone git@github.com:dehlen/git-tree-zsh.git "$ZSH_CUSTOM/plugins/git-tree-zsh"

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Symlink zshrc and aliases
ln -sf "$SCRIPT_DIR/zshrc" ~/.zshrc
ln -sf "$SCRIPT_DIR/aliases" ~/.aliases

source ~/.zshrc
