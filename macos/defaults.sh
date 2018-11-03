#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

###############################################################################
# Defaults                                                                    #
###############################################################################

# Show the ~/Library folder.
chflags nohidden ~/Library

# Use AirDrop over every interface.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Display the file extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Always use the column view in Finder
defaults write com.apple.Finder FXPreferredViewStyle clmv

# Disable the warning when changing file extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Enable remove items from trash after 30 days 
defaults write com.apple.finder FXRemoveOldTrashItems -bool true

# Enable bottom-left hot corner
defaults write com.apple.dock wvous-bl-corner -int 4

# Enable three fingers drag
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerSwipeGesture -int 1

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable some menu bar icons: Time Machine, Battery
defaults -currentHost write com.apple.systemuiserver dontAutoLoad -array \
 "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
 "/System/Library/CoreServices/Menu Extras/Battery.menu" \
 "/System/Library/CoreServices/Menu Extras/User.menu"

# Disable Siri and remove the menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.Siri.plist 2> /dev/null

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Set up Safari for development.
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

###############################################################################
# Terminal & iTerm 2                                                          #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

###############################################################################
# Time Machine                                                                #
###############################################################################

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

###############################################################################
# Photos                                                                      #
###############################################################################

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

###############################################################################
# Transmission.app                                                            #
###############################################################################

# Use `~/Download/Torrents` to store incomplete downloads
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Downloads/Torrents"

# Trash original torrent files
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

echo "Done. Note that some of these changes require a logout/restart to take effect."
