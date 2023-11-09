#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"


# Mac Mouse Fix
defaults import com.nuebling.mac-mouse-fix.helper preferences/com.nuebling.mac-mouse-fix.helper.plist
defaults import com.nuebling.mac-mouse-fix preferences/com.nuebling.mac-mouse-fix.plist