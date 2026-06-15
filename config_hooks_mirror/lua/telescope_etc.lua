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
	telescope.load_extension("advanced_git_search")
	telescope.load_extension("fzf")
	telescope.load_extension("project")
	-- print("loaded telescope with fzf-native")

	local telescope_builtin = require("telescope.builtin")
	map_explicit({
		mode = "n",
		sequence = "<leader>ff",
		action = function()
			telescope_builtin.find_files()
		end,
		desc = "Find Files",
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>gf",
		action = function()
			telescope_builtin.git_files()
		end,
		desc = "Find Git Files",
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>fg",
		action = function()
			telescope_builtin.live_grep()
		end,
		desc = "Live Grep",
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>fb",
		action = function()
			telescope_builtin.buffers()
		end,
		desc = "Find Buffers",
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>fh",
		action = function()
			telescope_builtin.help_tags()
		end,
		desc = "Find Help Tags",
	})
end)

--─────────────────────────────────────────────────────────────────────────────
--──── mappings ───────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

map_explicit({
	mode = "n",
	sequence = "<leader>ff",
	action = make_setup_function(function()
		require("telescope.builtin").find_files()
	end),
	desc = "Find Files",
})
map_explicit({
	mode = "n",
	sequence = "<leader>gf",
	action = function()
		require("telescope.builtin").git_files()
	end,
	desc = "Find Git Files",
})
map_explicit({
	mode = "n",
	sequence = "<leader>fg",
	action = function()
		require("telescope.builtin").live_grep()
	end,
	desc = "Live Grep",
})
map_explicit({
	mode = "n",
	sequence = "<leader>fb",
	action = function()
		require("telescope.builtin").buffers()
	end,
	desc = "Find Buffers",
})
map_explicit({
	mode = "n",
	sequence = "<leader>fh",
	action = function()
		require("telescope.builtin").help_tags()
	end,
	desc = "Find Help Tags",
})
