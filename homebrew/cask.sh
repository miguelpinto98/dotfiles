#!/bin/bash

plugins=(
	1password
	alt-tab
	calibre
	dash
	figma
	imageoptim
	iterm2
	qlcolorcode
	qlstephen
	qlmarkdown
	quicklook-json
	quicklook-csv
	qlimagesize
	qlvideo
	maccy
	ngrok
	rectangle
	spotify
	sublime-text
	stats
	the-unarchiver
	transmission
	tunnelblick
	visual-studio-code
	vlc
	zoom
)
brew install --cask "${plugins[@]}"
