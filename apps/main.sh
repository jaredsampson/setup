#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"


main () {
    ./iterm.sh
    ./moom.sh
    ./vim.sh
}


main "$@"
