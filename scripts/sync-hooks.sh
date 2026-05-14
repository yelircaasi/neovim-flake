#!/usr/bin/env bash

set -euo pipefail

# if [[ $# -ne 2 ]]; then
#   echo "Usage: $(basename "$0") <file1> <file2>"
#   exit 1
# fi

function sync_hooks() {
    A="$HOME/.config/nvim/$1"
    B="$HOME/repos/neovim-flake/config_hooks_mirror/$1"

    if [[ ! -f "$A" && ! -f "$B" ]]; then
    echo "Error: neither file exists."
    exit 1
    elif [[ ! -f "$A" ]]; then
    echo "$B -> $A"
    cp "$B" "$A"
    elif [[ ! -f "$B" ]]; then
    echo "$A -> $B"
    cp "$A" "$B"
    elif [[ "$A" -nt "$B" ]]; then
    echo "$A -> $B"
    cp "$A" "$B"
    elif [[ "$B" -nt "$A" ]]; then
    echo "$B -> $A"
    cp "$B" "$A"
    else
    echo "Files are identical in age, nothing to do."
    fi
}

sync_hooks before_init.lua
sync_hooks after_init.lua
