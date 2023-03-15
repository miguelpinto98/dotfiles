#!/bin/bash

libraries=(
	npm-check-updates
	svgo
)
npm install -g "${libraries[@]}"
