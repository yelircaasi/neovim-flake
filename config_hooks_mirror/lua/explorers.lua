local load_yazi = function()
	setup_plugin("yazi", {
		open_for_directories = true,
		keymaps = { show_help = "<f1>" },
	})
end

setup_plugin("yazi", function(yazi)
	utils.packadd("plenary")
	yazi.setup({
		open_for_directories = true,
		keymaps = { show_help = "<f1>" },
	})
	map_explicit({
		"<leader>-",
		mode = { "n", "v" },
		"<cmd>Yazi<cr>",
		desc = "Open yazi at the current file",
	})
	map_explicit({
		-- Open in the current working directory
		"<leader>cw",
		"<cmd>Yazi cwd<cr>",
		desc = "Open the file manager in nvim's working directory",
	})
	map_explicit({
		"<c-up>",
		"<cmd>Yazi toggle<cr>",
		desc = "Resume the last yazi session",
	})
end)

setup_plugin("neo-tree")
setup_plugin("nvim-tree", function(nvimtree)
	utils.packadd("nvim-web-devicons")
	nvimtree.setup()
end)

setup_plugin("oil", function(oil)
	utils.packadd("mini.icons")
	-- OR: utils.packadd("nvim-web-devicons")

	---@module 'oil'
	---@type oil.SetupOpts
	oil.setup({})
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
end)
