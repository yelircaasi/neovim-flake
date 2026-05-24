setup_plugin("lazydev")
setup_plugin("rustaceanvim")
setup_plugin("crates")
-- local ht = setup_plugin("haskell-tools")
-- ht.lsp.start()

vim.filetype.add({
	extension = {
		hs = "haskell",
		rs = "rust",
	},
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "haskell",
	callback = function()
		print("Haskell file detected!")
		local ht = setup_plugin("haskell-tools")
		ht.lsp.start()
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function()
		print("Rust file detected!")
		local rnv = setup_plugin("rustaceanvim")
	end,
})

setup_plugin("xit")
