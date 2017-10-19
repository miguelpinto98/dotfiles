
# Show the ~/Library folder.
chflags nohidden ~/Library

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

# Set up Safari for development.
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Disable some menu bar icons: Time Machine, Battery
defaults -currentHost write com.apple.systemuiserver dontAutoLoad -array \
 "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
 "/System/Library/CoreServices/Menu Extras/Battery.menu" \
 "/System/Library/CoreServices/Menu Extras/User.menu"

# Disable Siri and remove the menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.Siri.plist 2> /dev/null
