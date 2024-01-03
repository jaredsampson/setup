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


use_brewed_bash() {
    print_step "Using brewed bash"
    echo -e "\nCurrent shell is: $SHELL"
    brew_bash="$(brew --prefix)/bin/bash"
    if [ -f "$brew_bash" ] && [ "$SHELL" != "$brew_bash" ]; then
        echo "Setting shell to: $brew_bash"
        sudo chsh -s "$brew_bash" "$USER"
    fi
    echo
}


main() {
    profiles="$@"

    install_homebrew

    # Apple silicon Macs need the `arch -amd64` prefix
    brew="brew"
    if [[ $(uname -p) == "arm" ]]; then
        brew="arch -arm64 brew"
    fi

    $brew update

    for profile in base $profiles; do
        # print_step "Installing Brewfile from profile \`$profile\`..."
        brewfile="profiles/$profile/Brewfile"
        $brew bundle install --no-upgrade --no-lock --file "$brewfile"
    done

    use_brewed_bash

}

main "$@"
