-- LINK
-- DESC
local nix_develop_defaults = {} -- TODO
setup_plugin("nix-develop", nix_develop_defaults)

vim.lsp.config["nixd"] = {} -- TODO (?)

vim.lsp.enable("nixd")
