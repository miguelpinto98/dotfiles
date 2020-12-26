#!/bin/bash

brew audit --cask

plugins=(
	qlcolorcode
	qlstephen
	qlmarkdown
	quicklook-json
	quicklook-csv
	qlimagesize
	qlvideo
)
brew install --cask "${plugins[@]}"
