#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# Moom
if [[ -f ~/Library/Preferences/com.manytricks.Moom.plist ]]; then
    killall Moom
    defaults import com.manytricks.Moom preferences/moom.plist
    open -a Moom
fi

# iTerm
defaults import com.googlecode.iterm2.plist preferences/com.googlecode.iterm2.plist
