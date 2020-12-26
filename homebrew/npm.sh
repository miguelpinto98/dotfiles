#!/bin/bash

nvm install 14.15.3

libraries=(
	@angular/cli
	@sentry/cli
	http-server
	svgo
)
npm install -g "${libraries[@]}"
