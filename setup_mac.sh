#!/bin/bash -e

# Disable OS X Dashboard
#   Enable: defaults delete com.apple.dashboard mcx-disabled
defaults write com.apple.dashboard mcx-disabled -boolean true
killall Dock
