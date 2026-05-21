setup_plugin("vim-floaterm", function()
	utils.packadd("vim-floaterm")
	-- Optional: Set global configurations for floaterm if needed
	vim.g.floaterm_width = 0.8
	vim.g.floaterm_height = 0.8

	-- This is the crucial part for color integration
	-- TODO
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
