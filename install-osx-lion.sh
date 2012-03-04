#!/bin/bash

MY_PATH=`dirname "$0"`
MY_PATH=`( cd "$MY_PATH" && pwd )`

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Configure the terminal to use a solarized color scheme and the zsh prompt
cp $MY_PATH/files/.osh/com.apple.Terminal.plist ~/Library/Preferences

# Configure the dock with a minimal set of persistant icons
cp $MY_PATH/files/.osh/com.apple.dock.plist ~/Library/Preferences
