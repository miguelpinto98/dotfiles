#!/bin/bash

# Install Caskroom
brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions

# Install packages
apps=(
    dropbox
    imageoptim
    istat-menus
    iterm2
    filezilla
    firefoxnightly
    google-chrome
    kaleidoscope
    ngrok
    paw
    slack
    spectacle
    spotify
    sublime-text
    the-unarchiver
    transmission
    visual-studio-code
    vlc
)

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize suspicious-package
