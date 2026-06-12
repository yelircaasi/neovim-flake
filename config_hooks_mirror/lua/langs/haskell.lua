local ht = setup_plugin("haskell-tools")

vim.api.nvim_create_autocmd("FileType", {
	pattern = "haskell",
	callback = function()
		print("Haskell file detected!")
		local ht = setup_plugin("haskell-tools")
		ht.lsp.start()
	end,
})

vim.lsp.config["haskell-language-server"] = { ------------------------------------------------------------------ HASKELL
	cmd = { "haskell-language-server" },
	filetypes = { "haskell" },
	root_markers = { { "*.cabal" }, ".git" },
	settings = {},
}

vim.lsp.config["haskell-ls"] = {} -- TODO (?)
