-- setup_plugin("rustaceanvim")

-- local ht = setup_plugin("haskell-tools")
-- ht.lsp.start()

vim.api.nvim_create_autocmd("FileType", {
	pattern = "haskell",
	callback = function()
		print("Haskell file detected!")
		local ht = setup_plugin("haskell-tools")
		ht.lsp.start()
	end,
})

setup_plugin("xit")
