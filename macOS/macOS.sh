#!/bin/bash

# Ask for the administrator password upfront
sudo -v

################################################################################
#### macOS default && Safari definitions

# Set computername
scutil --set ComputerName "mbp-mp"
scutil --set LocalHostName "mbpmp"
scutil --set HostName "mbpmp"
dscacheutil -flushcache # Flushes the DNS cache to see hostname changes

# Show ~/Library
chflags nohidden ~/Library

# Enable tap to click (Trackpad) for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Show all filename extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Set up Safari for development.
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write -g WebKitDeveloperExtras -bool true

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

################################################################################
## screen and desktop defintions

# Hot corners
# Possible values:
#   0: no-op
#   2: Mission Control
#   3: Show application windows
#   4: Desktop
#   5: Start screen saver
#   6: Disable screen saver
#   7: Dashboard
#  10: Put display to sleep
#  11: Launchpad
#  12: Notification Center
defaults write com.apple.dock wvous-bl-corner -int 4
defaults write com.apple.dock wvous-bl-modifier -int 0


################################################################################
#### SSD definitions

# Turn off local Time Machine snapshots [laptops only]
sudo tmutil disablelocal

# Turn off sudden motion sensor [no HDD only]
sudo pmset -a sms 0

# Activate TRIM with trim force
sudo trimforce enable
