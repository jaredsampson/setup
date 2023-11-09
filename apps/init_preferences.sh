#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"

PLIST_DIR="preferences"


# Check whether a preference file already exists for this domain
plist_domain_exists() {
    domain="$1"
    defaults read "$domain" > /dev/null 2>&1 
    return "$?"
}


# Ensure app is not running and install preference file
killall_and_init_pref() {
    echo killall_and_init_pref:
    echo app=$1
    echo domain=$2
    echo pref_file=$3
    echo
}


init_missing_pref() {
    app="$1"
    plist="$2"

    domain="${plist%.plist}"
    pref_file="$PLIST_DIR/$plist"

    if [[ ! plist_domain_exists $domain]]; then
        killall_and_init_pref $app $domain $pref_file
    fi
}

initialize_missing_preferences() {
    init_missing_pref "iTerm" "com.googlecode.iterm2.plist"
    init_missing_pref ""
}


main () {
    initialize_missing_preferences
}


main "$@"

# # iTerm
# defaults import com.googlecode.iterm2 preferences/com.googlecode.iterm2.plist

# # Mac Mouse Fix
# defaults import com.nuebling.mac-mouse-fix.helper preferences/com.nuebling.mac-mouse-fix.helper.plist
# defaults import com.nuebling.mac-mouse-fix preferences/com.nuebling.mac-mouse-fix.plist#!/usr/bin/env bash

# # Moom
# killall Moom
# defaults import com.manytricks.Moom preferences/moom.plist
# open -a Moom
#
#
# Rstudio
# ~/.config/rstudio/rstudio-prefs.json
#
# Typinator
# com.macility.typinator2.plist
# Library/Application\ Support/Typinator/Sets
