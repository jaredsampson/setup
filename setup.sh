#!/usr/bin/env bash

############################################################

# Config

# Github
github_repo="jaredsampson/setup"
origin="git@github.com:${github_repo}.git"
tarball_url="https://github.com/${github_repo}/tarball/main"

# Local 
repo_path="$HOME/.setup"



############################################################

# Utils

function print_step() {
    echo -e "\n - $1"
}



############################################################

# Bootstrap-specific

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
    

############################################################

# Main workflow

function main() {
    
    # Work in the repo directory
    cd "$(dirname "${BASH_SOURCE[0]}")" \
        || exit 1

    pwd

    # Download dotfiles if we didn't run this script directly
    if ! work_dir_has_setup_script; then
        echo no setup script
        echo downloading repo
        download repo \
            && cd "$repo_path"
        echo
        echo install Xcode command line tools
        echo
        echo install dotfiles
        echo
        echo install application configure macos
        echo
        echo configure applicationss
        echo
        echo configure macos
        echo
        echo configure applications
        
    else
        echo found setup script
    fi
}


main "$@"

