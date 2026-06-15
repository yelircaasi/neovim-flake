vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
})

--─────────────────────────────────────────────────────────────────────────────
--──── yanky ──────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

local yanky_defaults = {
	ring = {
		history_length = 100,
		storage = "shada",
		storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db", -- Only for sqlite storage
		sync_with_numbered_registers = true,
		cancel_event = "update",
		ignore_registers = { "_" },
		update_register_on_cycle = false,
		permanent_wrapper = nil,
	},
	picker = {
		select = {
			action = nil, -- nil to use default put action
		},
		telescope = {
			use_default_mappings = true, -- if default mappings should be used
			mappings = nil, -- nil to use default mappings or no mappings (see `use_default_mappings`)
		},
	},
	system_clipboard = {
		sync_with_ring = true,
		clipboard_register = nil,
	},
	highlight = {
		on_put = true,
		on_yank = true,
		timer = 500,
	},
	preserve_cursor_position = {
		enabled = true,
	},
	textobj = {
		enabled = false,
	},
}
setup_plugin("yanky", function(yanky)
	yanky.setup(yanky_defaults)

	map_explicit({
		mode = { "n", "x" },
		sequence = "p",
		action = "<Plug>(YankyPutAfter)",
	})
	map_explicit({
		mode = { "n", "x" },
		sequence = "P",
		action = "<Plug>(YankyPutBefore)",
	})
	map_explicit({
		mode = { "n", "x" },
		sequence = "gp",
		action = "<Plug>(YankyGPutAfter)",
	})
	map_explicit({
		mode = { "n", "x" },
		sequence = "gP",
		action = "<Plug>(YankyGPutBefore)",
	})

	map_explicit({
		mode = "n",
		sequence = "<c-p>",
		action = "<Plug>(YankyPreviousEntry)",
	})
	map_explicit({
		mode = "n",
		sequence = "<c-n>",
		action = "<Plug>(YankyNextEntry)",
	})

	-- And these keymaps for tpope/vim-unimpaired like usage:
	map_explicit({
		mode = "n",
		sequence = "]p",
		action = "<Plug>(YankyPutIndentAfterLinewise)",
	})
	map_explicit({
		mode = "n",
		sequence = "[p",
		action = "<Plug>(YankyPutIndentBeforeLinewise)",
	})
	map_explicit({
		mode = "n",
		sequence = "]P",
		action = "<Plug>(YankyPutIndentAfterLinewise)",
	})
	map_explicit({
		mode = "n",
		sequence = "[P",
		action = "<Plug>(YankyPutIndentBeforeLinewise)",
	})

	map_explicit({
		mode = "n",
		sequence = ">p",
		action = "<Plug>(YankyPutIndentAfterShiftRight)",
	})
	map_explicit({
		mode = "n",
		sequence = "<p",
		action = "<Plug>(YankyPutIndentAfterShiftLeft)",
	})
	map_explicit({
		mode = "n",
		sequence = ">P",
		action = "<Plug>(YankyPutIndentBeforeShiftRight)",
	})
	map_explicit({
		mode = "n",
		sequence = "<P",
		action = "<Plug>(YankyPutIndentBeforeShiftLeft)",
	})

	map_explicit({
		mode = "n",
		sequence = "=p",
		action = "<Plug>(YankyPutAfterFilter)",
	})
	map_explicit({
		mode = "n",
		sequence = "=P",
		action = "<Plug>(YankyPutBeforeFilter)",
	})

	-- yank-ring:
	map_explicit({
		mode = "n",
		sequence = "<c-p>",
		action = "<Plug>(YankyPreviousEntry)",
	})
	map_explicit({
		mode = "n",
		sequence = "<c-n>",
		action = "<Plug>(YankyNextEntry)",
	})
end)

--─────────────────────────────────────────────────────────────────────────────
--──── lazyclip ───────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

local lazyclip_defaults = {
	-- Core settings
	max_history = 100, -- Maximum number of items to keep in history
	items_per_page = 9, -- Number of items to show per page
	min_chars = 5, -- Minimum characters required to store item

	-- Window appearance
	window = {
		relative = "editor",
		width = 70, -- Width of the floating window
		height = 12, -- Height of the floating window
		border = "rounded", -- Border style
	},

	-- Internal keymaps for the lazyclip window
	keymaps = {
		close_window = "q", -- Close the clipboard window
		prev_page = "h", -- Go to previous page
		next_page = "l", -- Go to next page
		paste_selected = "<CR>", -- Paste the selected item
		move_up = "k", -- Move selection up
		move_down = "j", -- Move selection down
		delete_item = "d", -- Delete selected item
	},
}
setup_plugin("lazyclip", lazyclip_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── pasta ──────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

setup_plugin("pasta", function(pasta)
	map_explicit({
		mode = { "n", "x" },
		"p",
		require("pasta.mapping").p,
	})
	map_explicit({
		mode = { "n", "x" },
		"P",
		require("pasta.mapping").P,
	})

	-- This is the default. You can omit `setup` call if you don't want to change this.
	local pasta_config = pasta.config
	pasta_config.next_key = vim.keycode("<C-n>")
	pasta_config.prev_key = vim.keycode("<C-p>")
	pasta_config.indent_key = vim.keycode(",")
	pasta_config.indent_fix = true
end)

-- TODO: resolve and remove duplicate (?)
setup_plugin("nvim-pasta", function(pasta)
	pasta.setup({
		-- Reindent pasted text to match surrounding context
		next_key = vim.api.nvim_replace_termcodes("<C-n>", true, true, true),
		prev_key = vim.api.nvim_replace_termcodes("<C-p>", true, true, true),
	})
	-- p/P are remapped by pasta automatically; C-n/C-p cycle through paste history
end)

--─────────────────────────────────────────────────────────────────────────────
--──── wastebin ───────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- TODO: install https://github.com/matze/wastebin

local wastebin_defaults = {
	-- URL of wastebin service to POST pastes to
	url = vim.env.WASTEBIN_URL or "https://foo.bar.com",
	-- argv list used to POST the content; the URL is appended automatically
	post_cmd = { "curl", "-s", "-H", "Content-Type: application/json", "--data-binary", "@-" },
	-- argv list used to open the resulting URL; the URL is appended automatically
	open_cmd = { "open" },
	-- Ask for confirmation
	ask = true,
}
setup_plugin("wastebin", wastebin_defaults)
