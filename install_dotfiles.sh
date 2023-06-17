#!/usr/bin/env bash

# Most of this is from https://www.atlassian.com/git/tutorials/dotfiles
# except using `dotfiles` instead of `config`.

declare -r dotfiles_repo="jaredsampson/dotfiles"
declare -r dotfiles_origin="git@github.com:${dotfiles_repo}.git"
declare -r dotfiles_dir="$HOME/.dotfiles"

# Allow the following alias to work within this script
shopt -s expand_aliases
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

if [ -d "$dotfiles_dir" ]; then
    echo "Using existing dotfiles directory at $dotfiles_dir"
else
    # Get the repo
    git clone --bare "$dotfiles_origin" "$dotfiles_dir"

    # TODO add error handling here
    # Checkout the dotfiles and make a backup if there were conflicts
    # mkdir -p $HOME/.dotfiles_backup && \
    #     dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
    #     xargs -I{} mv {} .dotfiles-backup/{}
fi

# Sanity check that checkout worked
dotfiles checkout > /dev/null

# Ignore untracked files since we're working in the home directory
dotfiles config --local status.showUntrackedFiles no

