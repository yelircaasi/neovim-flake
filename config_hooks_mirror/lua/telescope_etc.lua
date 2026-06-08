-- TELESCOPE =================================================================================================

local telescope = utils.setup_plugin_default("telescope", function(telescope)
	telescope.setup({
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
	})
	telescope.load_extension("fzf")
	telescope.load_extension("project")
	print("loaded telescope with fzf-native")

	local telescope_builtin = require("telescope.builtin")
	map("n", "<leader>ff", function()
		telescope_builtin.find_files()
	end, { desc = "Find Files" })
	map("n", "<leader>gf", function()
		telescope_builtin.git_files()
	end, { desc = "Find Git Files" })
	map("n", "<leader>fg", function()
		telescope_builtin.live_grep()
	end, { desc = "Live Grep" })
	map("n", "<leader>fb", function()
		telescope_builtin.buffers()
	end, { desc = "Find Buffers" })
	map("n", "<leader>fh", function()
		telescope_builtin.help_tags()
	end, { desc = "Find Help Tags" })
end)
