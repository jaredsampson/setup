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
    profiles="$@"

    install_homebrew
    brew update

    for profile in base $profiles; do
        # print_step "Installing Brewfile from profile \`$profile\`..."
        brewfile="profiles/$profile/Brewfile"
        brew bundle install --no-lock --file "$brewfile"
    done
}

main "$@"
