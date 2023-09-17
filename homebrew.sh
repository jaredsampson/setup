#!/usr/bin/env bash


homebrew_is_installed() {
    which brew > /dev/null
    return "$?"
}


install_homebrew() {
    if ! homebrew_is_installed; then
        printf "\n" | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &> /dev/null
        #  └─ simulate the ENTER keypress
    fi
}

main() {
    profiles="$@"

    install_homebrew
    brew update

    for profile in base $profiles; do
        echo $profile
    done
}

main "$@"
