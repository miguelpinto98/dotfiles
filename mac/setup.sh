#!/bin/bash

### Finder
##########

# show Library folder
chflags nohidden ~/Library

### System
##########

# Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Enable tap to click for trackpad
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Faster keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Always open everything in Finder's list view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# show all filename extensions
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool true

# show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show item info near icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null || true
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null || true
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null || true

# Show item info to the right of the icons on the desktop
/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist 2>/dev/null || true

# Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Avoid creating .DS_Store files on USB drives
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Display the Finder "Quit" option
defaults write com.apple.finder "QuitMenuItem" -bool "true"

# Automatically empty bin after 30 days
defaults write com.apple.finder "FXRemoveOldTrashItems" -bool "true"

### Safari
##########

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Show full website URL
defaults write com.apple.safari "ShowFullURLInSmartSearchField" -bool true

### Mail
########

# Display emails in threaded mode, sorted by date (oldest at the top)
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "no"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

### System
##########

# Enable Secure Keyboard Entry in Terminal.app
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Don't ask to use every drive for Time Machine
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

### DOCK
########

# Put the Dock on the right of the screen
defaults write com.apple.dock "orientation" -string "right"

# Do not display recent apps in the Dock
defaults write com.apple.dock "show-recents" -bool "false"

# Set the icon size of Dock items
defaults write com.apple.dock tilesize -int 48

# Minimize windows into their application's icon
defaults write com.apple.dock minimize-to-application -bool true

# Keep Dock visible (disable auto-hide)
defaults write com.apple.dock autohide -bool false

### Screenshot
#############

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

### Apply Changes
#################

echo "Applying changes..."
killall Finder
killall Dock
killall SystemUIServer

echo "Done! Some changes may require a logout/restart to take effect."
