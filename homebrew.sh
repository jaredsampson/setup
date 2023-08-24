#!/usr/bin/env bash

homebrew_is_installed() {
    which brew > /dev/null
    return "$?"
}


install_homebrew() {
    url="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
    if ! homebrew_is_installed; then
        printf "\n" | /bin/bash -c "$(curl -fsSL ${url})"
        #  └─ simulate the ENTER keypress
    fi
}

main() {
    install_homebrew
    brew update
}

main
