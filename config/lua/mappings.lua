print('mappings.lua loaded')

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>alf", function()
	print("A lua func")
end, { noremap = true })
