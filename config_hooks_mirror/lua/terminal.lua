utils.packadd("vim-floaterm", function()
	vim.g.floaterm_width = 0.8
	vim.g.floaterm_height = 0.8
end)

setup_plugin("toggleterm", {
	open_mapping = [[<c-\>]],
	direction = "float",
	-- this is the key to inheriting your colorscheme's background
	highlights = {
		Normal = {
			link = "Normal",
		},
		NormalFloat = {
			link = "NormalFloat",
		},
	},
})

utils.packadd("termim")
