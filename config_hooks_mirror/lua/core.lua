setup_plugin("which-key", function(which_key)
	vim.o.timeout = true
	vim.o.timeoutlen = 300
	which_key.setup({})
end)
setup_plugin("plenary")
setup_plugin("nio")
setup_plugin("nvim-web-devicons")

setup_plugin("mini.indent")
setup_plugin("mini.keymap")
setup_plugin("mini.sessions")
setup_plugin("mini.pick")
setup_plugin("mini.pairs")
setup_plugin("mini.icons")
setup_plugin("mini.surround")
setup_plugin("mini.comment", {})
setup_plugin("mini.hipatterns")
setup_plugin("mini.indentscope")
setup_plugin("mini.marks")
setup_plugin("mini.fold")
setup_plugin("mini.terminal")

setup_plugin("zen-mode", {
	wezterm = {
		enabled = true,
		-- can be either an absolute font size or the number of incremental steps
		font = "+4", -- (10% increase per step)
	},
})
vim.o.laststatus = 3
setup_plugin("lualine", {
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
})

setup_plugin("nvim-navic")
setup_plugin("bufferline")
setup_plugin("statuscol")
