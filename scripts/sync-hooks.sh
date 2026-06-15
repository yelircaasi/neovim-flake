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
    echo "Error: neither file exists: $A, $B."
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
sync_hooks lua/ai.lua
sync_hooks lua/clipboard.lua
sync_hooks lua/cloud.lua
sync_hooks lua/colors.lua
sync_hooks lua/commands.lua
sync_hooks lua/completion.lua
sync_hooks lua/core.lua
sync_hooks lua/debugging.lua
sync_hooks lua/diff.lua
sync_hooks lua/editing.lua
sync_hooks lua/execution.lua
sync_hooks lua/explorers.lua
sync_hooks lua/folding.lua
sync_hooks lua/git.lua
sync_hooks lua/lsp_etc.lua
sync_hooks lua/macros.lua
sync_hooks lua/mappings.lua
sync_hooks lua/miscellaneous.lua
sync_hooks lua/navigation.lua
sync_hooks lua/options.lua
sync_hooks lua/task_runner.lua
sync_hooks lua/projects.lua
sync_hooks lua/search.lua
sync_hooks lua/sketches.lua
sync_hooks lua/telescope_etc.lua
sync_hooks lua/terminal.lua
sync_hooks lua/testing.lua
sync_hooks lua/tmp.lua
sync_hooks lua/treesitter.lua
sync_hooks lua/ui.lua
sync_hooks lua/wezterm.lua
# sync_hooks lua/wezterm_send.lua

sync_hooks lua/langs/init.lua
sync_hooks lua/langs/go.lua
sync_hooks lua/langs/haskell.lua
sync_hooks lua/langs/json_yaml.lua
sync_hooks lua/langs/lua_language.lua
sync_hooks lua/langs/markdown.lua
sync_hooks lua/langs/multilang.lua
sync_hooks lua/langs/nix.lua
sync_hooks lua/langs/python.lua
sync_hooks lua/langs/rust.lua
sync_hooks lua/langs/tex.lua
sync_hooks lua/langs/typst.lua
sync_hooks lua/langs/xit.lua
