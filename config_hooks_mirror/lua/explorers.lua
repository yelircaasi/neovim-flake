local yazi = setup_plugin("yazi", function(yazi)
	utils.packadd("plenary")
	yazi.setup({
		open_for_directories = true,
		keymaps = { show_help = "<f1>" },
	})
	map_explicit({
		mode = { "n", "v" },
		sequence = "<leader>-",
		action = "<cmd>Yazi<cr>",
		opts = { desc = "Open yazi at the current file" },
	})
	map_explicit({
		mode = { "n", "v" },
		sequence = "<leader>cw",
		action = "<cmd>Yazi cwd<cr>",
		opts = { desc = "Open the file manager in nvim's working directory" },
	})
	map_explicit({
		mode = { "n", "v" },
		sequence = "<c-up>",
		action = "<cmd>Yazi toggle<cr>",
		opts = { desc = "Resume the last yazi session" },
	})
end)

setup_plugin("oil", function(oil)
	-- utils.packadd("mini.icons")
	-- OR: utils.packadd("nvim-web-devicons")

	---@module 'oil'
	---@type oil.SetupOpts
	oil.setup({})
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
end)
