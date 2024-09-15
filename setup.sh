#!/usr/bin/env bash

############################################################
# Config
############################################################

# Github
github_user="jaredsampson"
github_repo="${github_user}/setup"
github_base="git@${github_user}.github.com"
origin="${github_base}:${github_repo}.git"
tarball_url="https://github.com/${github_repo}/tarball/main"

# Local
repo_path="$HOME/projects/setup"



############################################################
# Utils
############################################################

function print_step() {
    echo -e "$1"
}


ask_for_sudo() {
    # Ask for the administrator password upfront.
    sudo -v &> /dev/null

    # Update existing `sudo` time stamp until this script has finished.
    # https://gist.github.com/cowboy/3118588
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done &> /dev/null &
}



############################################################
# Bootstrap-specific
############################################################

function xcode_command_line_tools_are_installed() {
    xcode-select --print-path &> /dev/null
}


function install_xcode_command_line_tools() {
    print_step "Installing XCode Command Line Tools..."
    xcode-select --install
    until xcode_command_line_tools_are_installed; do
        sleep 5
    done
}


function require_xcode_command_line_tools() {
    if xcode_command_line_tools_are_installed; then
        print_step "XCode Command Line Tools are installed."
    else
        install_xcode_command_line_tools
        wait_for_xcode_command_line_tools
    fi
}


# Modified from alrra/dotfiles
function download() {
    local url="$1"
    local output="$2"

    if command -v "curl" &> /dev/null; then
        curl -LsSo "$output" "$url" &> /dev/null
        #     │││└─ write output to file
        #     ││└─ show error messages
        #     │└─ don't show the progress meter
        #     └─ follow redirects
        return $?
    elif command -v "wget" &> /dev/null; then
        wget -qO "$output" "$url" &> /dev/null
        #     │└─ write output to file
        #     └─ don't show output
        return $?
    fi

    return 1
}


function extract() {
    local archive="$1"
    local output_dir="$2"
    tar -xf "$archive" --strip-components 1 -C "$output_dir" ||
    tar -xzf "$archive" --strip-components 1 -C "$output_dir" ||
    return 1
}


function bash_source_is_local_setup_script() {
    printf "%s" "${BASH_SOURCE[0]}" | grep "setup.sh"
    return $?
} 


function download_repo() {

    # Download archive to temp file
    print_step "Downloading setup repo..."
    tmpfile="$(mktemp /tmp/XXXXX)"
    download "$tarball_url" "$tmpfile" \
        && downloaded=true

    # Unpack archive to repo path
    print_step "Extracting to $repo_path..."
    mkdir -p "$repo_path" \
        && extract "$tmpfile" "$repo_path" \
        && extracted=true

    # Always remove temp file
    rm $tmpfile

    # Return code
    if [ "$downloaded" = "true" ] && [ "$extracted" = "true" ]; then
        return 0
    else
        return 1
    fi
}


function github_ssh_access_works() {
    ssh -T "$github_base" 2>&1 | grep -q "$github_user"
    return $?
}


function configure_github_ssh_key() {
    print_step "Checking GitHub SSH key"
    private_key="$HOME/.ssh/id_${github_user}@github"
    public_key="${private_key}.pub"
    # Don't overwrite existing key
    if [[ -f "$private_key" && -f "$public_key" ]]; then
        print_step "  Using existing GitHub SSH key pair."
    else
        print_step "  Generating new GitHub SSH keys..."
        git clone https://github.com/dolmen/github-keygen.git > /dev/null
        cd github-keygen
        ./github-keygen "$github_user"
        cd ..
        rm -Rf github-keygen
    fi

    if github_ssh_access_works; then
        echo -e "  Successfully authenticated with GitHub!\n"
        return 0
    fi

    while ! github_ssh_access_works; do
        cat $public_key | pbcopy
        echo
        echo "The generated SSH key has been copied to the clipboard."
        echo
        echo "Please go to https://github.com/settings/keys and add the key,"
        echo "then come back here to continue setup."

        read -n 1 -s -r -p "Press any key to continue."
        echo
    done
    return 0
}


function bootstrap() {
    require_xcode_command_line_tools
    configure_github_ssh_key
    git clone "$origin" "$repo_path" && cd "$repo_path"
}


function setup() {
    profiles="$@"
    print_step "setting up dotfiles"
    ./install_dotfiles.sh
    print_step "setting up homebrew"
    ./homebrew.sh "$profiles"
    print_step "setting up os"
    ./os.sh
    print_step "setting up hotkeys"
    ./hotkeys.sh
    print_step "setting up applications"
    apps/main.sh
}



############################################################
# Main workflow
############################################################

function main() {
    profiles="$@"

    # Work in the repo directory
    cd "$(dirname "${BASH_SOURCE[0]}")" \
        || exit 1
    print_step "Starting in $(pwd)..."

    # Get sudo permission at the start.
    ask_for_sudo

    # Download the repo if we're not running from a local copy
    if ! bash_source_is_local_setup_script; then
        print_step "No local setup script found...starting bootstrap."
        bootstrap
    fi

    # check_repo

    setup "$profiles"
}


main "$@"
