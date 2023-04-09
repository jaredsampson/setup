#!/usr/bin/env bash

############################################################
# Config
############################################################

# Github
github_repo="jaredsampson/setup"
origin="git@github.com:${github_repo}.git"
tarball_url="https://github.com/${github_repo}/tarball/main"

# Local 
repo_path="$HOME/.setup"



############################################################
# Utils
############################################################

function print_step() {
    echo -e "$1"
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
}


function require_xcode_command_line_tools() {
    if xcode_command_line_tools_are_installed; then
        print_step "XCode Command Line Tools are installed."
    else
        install_xcode_command_line_tools
    fi
}


# Modified from alrra/dotfiles
function download() {
    local url="$1"
    local output="$2"

    if command -v "curl" &> /dev/null; then
        curl -LsSo "$output" "$url" &> /dev/null
        return $?
    # elif command -v "wget" &> /dev/null; then
    #     wget \
    #         --quiet \
    #         --output-document="$output" \
    #         "$url" \
    #             &> /dev/null
    #     return $?
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


function work_dir_has_setup_script() {
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


function bootstrap() {
    require_xcode_command_line_tools
    download_repo && cd "$repo_path"
    echo TBD install dotfiles
    echo TBD install application configure macos
    echo TBD configure applicationss
    echo TBD configure macos
    echo TBD configure applications
}


############################################################

# Main workflow

function main() {
    
    # Work in the repo directory
    cd "$(dirname "${BASH_SOURCE[0]}")" \
        || exit 1

    print_step "Starting in $(pwd)..."

    # Download the repo if we're not running from a local copy
    if ! work_dir_has_setup_script; then
        print_step "No setup script found...starting bootstrap."
        bootstrap
    else
        print_step "found setup script"
    fi
}


main "$@"
