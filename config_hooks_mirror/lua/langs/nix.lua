setup_plugin("nix-develop", {})

vim.lsp.config["nixd"] = {} -- TODO (?)

vim.lsp.enable("nixd")
