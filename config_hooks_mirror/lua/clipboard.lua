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
setup_plugin("yanky", yanky_defaults)
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")

-- And these keymaps for tpope/vim-unimpaired like usage:
vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")

-- yank-ring:
vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")

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
	vim.keymap.set({ "n", "x" }, "p", require("pasta.mapping").p)
	vim.keymap.set({ "n", "x" }, "P", require("pasta.mapping").P)

	-- This is the default. You can omit `setup` call if you don't want to change this.
	local pasta_config = pasta.config
	pasta_config.next_key = vim.keycode("<C-n>")
	pasta_config.prev_key = vim.keycode("<C-p>")
	pasta_config.indent_key = vim.keycode(",")
	pasta_config.indent_fix = true
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
