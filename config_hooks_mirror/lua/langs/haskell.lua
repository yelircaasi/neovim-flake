local ht = setup_plugin("haskell-tools")

vim.api.nvim_create_autocmd("FileType", {
	pattern = "haskell",
	callback = function()
		print("Haskell file detected!")
		local ht = setup_plugin("haskell-tools")
		ht.lsp.start()
	end,
})
