-- https://github.com/figsoda/nix-develop.nvim
-- Run `nix develop` without restarting neovim
local nix_develop_defaults = {} -- TODO
setup_plugin("nix-develop", nix_develop_defaults)
--[[
:NixDevelop
:NixDevelop .#foo
:NixDevelop --impure

:NixShell
:NixShell nixpkgs#hello

:DevenvShell
:DevenvShell --profile foo
--]]

vim.lsp.config["nixd"] = {} -- TODO (?)

vim.lsp.enable("nixd")
