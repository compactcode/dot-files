#!/bin/bash

MY_PATH=`dirname "$0"`
MY_PATH=`( cd "$MY_PATH" && pwd )`

# Enable tab in model dialogs
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeDebugMenu -bool true

# A terminal configured to use zsh by default
cp $MY_PATH/files/.osh/com.apple.Terminal.plist ~/Library/Preferences

# A gutted version of the dock
cp $MY_PATH/files/.osh/com.apple.dock.plist ~/Library/Preferences
